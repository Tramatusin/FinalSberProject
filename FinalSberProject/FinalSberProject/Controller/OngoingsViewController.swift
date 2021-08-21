//
//  ViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import UIKit

class OngoingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mangaList: [Manga]?
    var manhvaList: [Manga]?
    var manhuyaList: [Manga]?
    let someView = ViewForListController()
    let nm = NetworkManagerImp()
    
    override func loadView() {
        super.loadView()
        view = someView
        navigationItem.title = "Онгоинги"
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMangaList()
    }
    
    func loadMangaList(){
        guard let url = URL(string: Urls.manga.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                self?.mangaList = manga
                self?.someView.tableView.reloadData()
            }
        }
    }
    
    func loadManhvaList(){
        guard let url = URL(string: Urls.manhva.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                self?.manhvaList = manga
                self?.someView.tableView.reloadData()
            }
        }
    }
    
    func loadManhuyaList(){
        guard let url = URL(string: Urls.manhuya.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                self?.manhuyaList = manga
                self?.someView.tableView.reloadData()
            }
        }
    }
    
    func load(urlStr: URL,completion: @escaping ([Manga])->()){
        DispatchQueue.global().async { [weak self] in
            self?.nm.getMangaList(url: urlStr) { items in
                switch items{
                case .failure(let error):
                    print(error)
                case .success(let manga):
                    completion(manga)
                }
            }
        }
    }
    
}

extension OngoingsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mangaList?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTitleTableViewCell
        guard let indexManga = mangaList?[indexPath.row],
              let dataImageStr = indexManga.cover,
              let finalData = Data(base64Encoded: dataImageStr, options: .ignoreUnknownCharacters),
              let nameOfTitle = indexManga.name,
              let tags = indexManga.tags,
              let chaptesCount = indexManga.chapters?.count,
              let raiting = indexManga.rating_value else {return cell}
        cell.tapOnFavouriteButton = { button in
            button.tintColor = UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1)
            UIView.animate(withDuration: 1.3) {
                button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }
        cell.configureCell(name: nameOfTitle, data: finalData, tags: tags, chaptersCount: chaptesCount, raiting: raiting)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMangaVC = MangaViewController()
        currentMangaVC.currentManga = mangaList?[indexPath.row]
        navigationController?.pushViewController(currentMangaVC, animated: true)
    }
}
