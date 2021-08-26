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
    var searchManga: [Manga] = []
    let loadingVC = LoadingViewController()
    let someView = ViewForListController()
    let nm = NetworkManagerImp()
    
    override func loadView() {
        super.loadView()
        view = someView
        //navigationItem.title = "Онгоинги"
        navigationItem.titleView = someView.searchBar
        someView.searchBar.delegate = self
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadMangaList()
        displayLoader()
        loadManhvaList()
    }
    
    func loadMangaList(){
        guard let url = URL(string: Urls.manga.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                self?.mangaList = manga
                self?.someView.tableView.reloadData()
                self?.disapearLoader()
            }
        }
    }
    
    func loadManhvaList(){
        guard let url = URL(string: Urls.manhva.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                //self?.manhvaList = manga
                self?.mangaList = manga
                self?.someView.tableView.reloadData()
                self?.disapearLoader()
            }
        }
    }
    
    func loadManhuyaList(){
        guard let url = URL(string: Urls.manhuya.rawValue) else {return}
        load(urlStr: url) {[weak self] manga in
            DispatchQueue.main.async {
                self?.manhuyaList = manga
                self?.someView.tableView.reloadData()
                self?.disapearLoader()
            }
        }
    }
    
    func load(urlStr: URL,completion: @escaping ([Manga])->()){
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
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
    
    var tapOnFavButtonClousure:(UIButton)->() = { button in
        
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
        print(mangaList?[indexPath.row].code)
        navigationController?.pushViewController(currentMangaVC, animated: true)
    }
}

extension OngoingsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let mangas = mangaList else { return }
        
        searchManga = mangas.filter({ item in
            guard let name = item.name else { return false }
            return name.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        
        someView.tableView.reloadData()
    }
}

extension OngoingsViewController: LoaderManagerProtocol{
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
    
    func setupChildViewConstraint(){
        loadingVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            loadingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
