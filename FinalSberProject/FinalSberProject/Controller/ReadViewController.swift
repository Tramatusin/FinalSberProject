//
//  ReadViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 23.08.2021.
//

import UIKit

class ReadViewController: UIViewController {
    
    var currentManga: Manga?
    var currentChapter: Chapters?
    var pages: [Data]?
    let readView = ViewForPages()
    let networkManager = NetworkManagerImp()
    
    override func loadView() {
        super.loadView()
        view = readView
        readView.tableViewForPages.delegate = self
        readView.tableViewForPages.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPages()
    }
    
    func loadPages(){
        guard let code = currentManga?.code,
              let chapter = currentChapter,
              let url = URL(string:Urls.mangaChapter.rawValue) else { return }
        DispatchQueue.global().async { [weak self] in
            self?.networkManager.getPagesList(code: code, chapterManga: chapter, url: url) { result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let pages):
                    DispatchQueue.main.async {
                        self?.pages = pages
                        self?.readView.tableViewForPages.reloadData()
                    }
                }
            }
        }
    }
    
}

extension ReadViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pages?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PagesTableViewCell.identifier, for: indexPath) as! PagesTableViewCell
        guard let page = pages?[indexPath.row] else { return cell}
        cell.configureCell(pageData: page, numberOfPage: indexPath.row)
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let pages = pages, let image = UIImage(data: pages[indexPath.row]) else { return CGFloat(1000)}
        let imageRatio = image.size.width/image.size.height
        return tableView.frame.width/imageRatio
    }
    
}
