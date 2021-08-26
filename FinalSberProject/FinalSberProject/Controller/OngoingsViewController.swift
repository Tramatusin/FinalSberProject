//
//  ViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import UIKit

class OngoingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mangaList: [Manga] = []
    var manhvaList: [Manga] = []
    var manhuyaList: [Manga] = []
    var ongoingPageType: TypeOngoings = .manhva
    var searchManga: [Manga] = []
    let loadingVC = LoadingViewController()
    let someView = ViewForListController()
    let nm = NetworkManagerImp()
    let userDef = UserDefaultsManager()
    
    override func loadView() {
        super.loadView()
        view = someView
        navigationItem.titleView = someView.searchBar
        someView.searchBar.delegate = self
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        checkUserDefaults()
        displayLoader()
        setCurrentMangaListAfterButtonTap(pageType: ongoingPageType, listOfOngoing: setMangaList())
        tapOnButtons()
    }
    
    func tapOnButtons(){
        someView.tapOnMangaBut = { [weak self] in
            guard let self = self else { return }
            self.someView.mangaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            self.someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.setCurrentMangaListAfterButtonTap(pageType: .manga, listOfOngoing: self.mangaList)
        }
        
        someView.tapOnManhvaBut = { [weak self] in
            guard let self = self else { return }
            self.someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            self.someView.mangaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.setCurrentMangaListAfterButtonTap(pageType: .manhva, listOfOngoing: self.manhvaList)
        }

        someView.tapOnManhuyaBut = { [weak self] in
            guard let self = self else { return }
            self.someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.someView.mangaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
            self.someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            self.setCurrentMangaListAfterButtonTap(pageType: .manhuya, listOfOngoing: self.manhuyaList)
        }
    }

    func setCurrentMangaListAfterButtonTap(pageType: TypeOngoings, listOfOngoing: [Manga]){
        self.ongoingPageType = pageType
        userDef.setDataInUserDefaults(pageType: pageType, key: "type")
        if listOfOngoing.isEmpty{
            self.displayLoader()
            load(urlStr: pageType.rawValue)
            return
        }
        self.someView.tableView.reloadData()
    }
    
    func setMangaList()->[Manga]{
        switch ongoingPageType {
        case .manga:
            return mangaList
        case .manhva:
            return manhvaList
        case .manhuya:
            return manhuyaList
        }
    }
    
    func checkUserDefaults(){
        if let pageType = userDef.readDataOnUserDefaults(key: "type"){
            ongoingPageType = pageType
            switch pageType {
            case .manga:
                self.someView.mangaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            case .manhva:
                self.someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            case .manhuya:
                self.someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
            }
        }
    }
    
}

extension OngoingsViewController{

    func load(urlStr: String){
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let url = URL(string: urlStr) else { return }
            self?.nm.getMangaList(url: url) { items in
                switch items{
                case .failure(let error):
                    print(error)
                case .success(let manga):
                    switch self?.ongoingPageType {
                    case .manga:
                        self?.mangaList = manga
                        self?.endLoad()
                    case .manhva:
                        self?.manhvaList = manga
                        self?.endLoad()
                    case .manhuya:
                        self?.manhuyaList = manga
                        self?.endLoad()
                    case .none:
                        return
                    }
                }
            }
        }
    }
    
    func endLoad(){
        DispatchQueue.main.async {
            self.someView.tableView.reloadData()
            self.disapearLoader()
        }
    }
    
}

extension OngoingsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setMangaList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTitleTableViewCell
        let curMangaList: [Manga] = setMangaList()
        
        guard let dataImageStr = curMangaList[indexPath.row].cover,
              let finalData = Data(base64Encoded: dataImageStr, options: .ignoreUnknownCharacters),
              let nameOfTitle = curMangaList[indexPath.row].name,
              let tags = curMangaList[indexPath.row].tags,
              let chaptesCount = curMangaList[indexPath.row].chapters?.count,
              let raiting = curMangaList[indexPath.row].rating_value else {return cell}
        cell.configureCell(name: nameOfTitle, data: finalData, tags: tags, chaptersCount: chaptesCount, raiting: raiting)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMangaVC = MangaViewController()
        let mangaList = setMangaList()
        currentMangaVC.currentManga = mangaList[indexPath.row]
        //print(mangaList[indexPath.row].code)
        navigationController?.pushViewController(currentMangaVC, animated: true)
    }
}

extension OngoingsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mangas = setMangaList()
        
        searchManga = mangas.filter({ item in
            guard let name = item.name else { return false }
            return name.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        
        someView.tableView.reloadData()
    }
}

extension OngoingsViewController: LoaderManager{
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
