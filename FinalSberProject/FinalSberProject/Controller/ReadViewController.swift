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
    let urlForPage = "http://hsemanga.ddns.net:7000/getmanga/chapter/"
    var pages: [Data]?
    let readView = ViewForPages()
    let loadingVC = LoadingViewController()
    let networkManager = NetworkManagerImp()
    var curImage: UIImage?
    
    override func loadView() {
        super.loadView()
        view = readView
        loadingVC.labelForwWarning.isHidden = false
        readView.tableViewForPages.delegate = self
        readView.tableViewForPages.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLoader()
        loadPages()
    }
    
    func loadPages(){
        guard let code = currentManga?.code,
              let chapter = currentChapter,
              let url = URL(string: urlForPage) else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.networkManager.getPagesList(code: code, chapterManga: chapter, url: url) { result in
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let pages):
                    DispatchQueue.main.async {
                        self?.pages = pages
                        self?.readView.tableViewForPages.reloadData()
                        self?.disapearLoader()
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
        guard let pages = pages?[indexPath.row],
              let image = UIImage(data: pages)
        else { return cell}
        curImage = image
        cell.configureCell(pageData: image, numberOfPage: indexPath.row)
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let pages = pages?[indexPath.row],
              let image = UIImage(data: pages) else { return CGFloat(1000)}
        let imageRatio = image.size.width/image.size.height
        return tableView.frame.width/imageRatio
    }
    
}

extension ReadViewController: LoaderManager{
    
    func displayLoader() {
        self.addChild(loadingVC)
        self.view.addSubview(loadingVC.view)
        loadingVC.didMove(toParent: self)
        setupChildViewConstraint()
    }
    
    func disapearLoader() {
        loadingVC.willMove(toParent: nil)
        loadingVC.view.removeFromSuperview()
        loadingVC.removeFromParent()
    }
    
    func setupChildViewConstraint() {
        loadingVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            loadingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
