//
//  ViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import UIKit

class OngoingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var mangaList: [NetManga] = []
    private var manhvaList: [NetManga] = []
    private var manhuyaList: [NetManga] = []
    private var ongoingPageType: TypeOngoings = .manhva
    private var searchManga: [NetManga] = []
    private let loadingVC = LoadingViewController()
    private let someView = ViewForListController()
    private let networkDataManager = JSONParser(session: URLSession.shared)
    private let userDef = UserDefaultsManager()
    private let coreDataManager = CoreDataManagerImp()

    override func loadView() {
        view = someView
        navigationItem.titleView = someView.searchBar
        someView.searchBar.delegate = self
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserDefaults()
        // coreDataManager.clearObjects()
        // coreDataManager.printDataBase()
        displayLoader()
        setCurrentMangaListAfterButtonTap(pageType: ongoingPageType, listOfOngoing: setMangaList())
        tapOnButtons()

    }

    func tapOnButtons() {
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

    func setCurrentMangaListAfterButtonTap(pageType: TypeOngoings, listOfOngoing: [NetManga]) {
        self.ongoingPageType = pageType
        userDef.setDataInUserDefaults(pageType: pageType, key: "type")
        if listOfOngoing.isEmpty {
            self.displayLoader()
            load(urlStr: pageType.rawValue)
            // load(urlStr: "www.google.com")
            return
        }
        self.someView.tableView.reloadData()
    }

    func setMangaList() -> [NetManga] {
        switch ongoingPageType {
        case .manga:
            return mangaList
        case .manhva:
            return manhvaList
        case .manhuya:
            return manhuyaList
        }
    }

    func checkUserDefaults() {
        if let pageType = userDef.readDataOnUserDefaults(key: "type") {
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

extension OngoingsViewController {

    func load(urlStr: String) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let url = URL(string: urlStr) else { return }
            self?.networkDataManager.deserializeMangaData(url: url) { items in
                switch items {
                case .failure(let error):
                    guard let resManga = self?.coreDataManager.castLocalMangaToNetManga()
                    else { return }
                    self?.mangaList = resManga
                    self?.ongoingPageType = .manga
                    DispatchQueue.main.async {
                        self?.someView.manhvaBut.isHidden = true
                        self?.someView.manhuyaBut.isHidden = true
                        self?.someView.mangaBut.setTitle("Офлайн", for: .normal)
                    }
                    self?.endLoad()
                    print(error)
                case .success(let mangaData):
                    switch self?.ongoingPageType {
                    case .manga:
                        self?.mangaList = mangaData
                        self?.setDataInCoreData(mangas: mangaData)
                        self?.endLoad()
                    case .manhva:
                        self?.manhvaList = mangaData
                        self?.setDataInCoreData(mangas: mangaData)
                        self?.endLoad()
                    case .manhuya:
                        self?.manhuyaList = mangaData
                        self?.setDataInCoreData(mangas: mangaData)
                        self?.endLoad()
                    case .none:
                        return
                    }
                }
            }
        }
    }

    func endLoad() {
        DispatchQueue.main.async {
            self.someView.tableView.reloadData()
            self.disapearLoader()
        }
    }

    func setDataInCoreData(mangas: [NetManga]) {
        mangas.forEach({ coreDataManager.writeObject(manga: $0) })
    }

}

extension OngoingsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setMangaList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath)
                as? MangaTitleTableViewCell
        else { return tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) }
        let curMangaList: [NetManga] = setMangaList()
        let indexOfManga = curMangaList[indexPath.row]

        guard let dataImageStr = indexOfManga.cover,
              let finalData = Data(base64Encoded: dataImageStr, options: .ignoreUnknownCharacters),
              let nameOfTitle = indexOfManga.name,
              let tags = indexOfManga.tags,
              let chaptersCount =
                indexOfManga.chapters,
              let raiting = curMangaList[indexPath.row].ratingValue else { return cell }
        cell.configureCell(name: nameOfTitle, data: finalData,
                           tags: tags, chaptersCount: chaptersCount.count, raiting: raiting)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMangaVC = MangaViewController()
        let mangaList = setMangaList()
        currentMangaVC.currentManga = mangaList[indexPath.row]
        // print(mangaList[indexPath.row].code)
        navigationController?.pushViewController(currentMangaVC, animated: true)
    }
}

extension OngoingsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mangas = setMangaList()

        searchManga = mangas.filter({ item in
            guard let name = item.name else { return false }
            return name.lowercased().prefix(searchText.count) == searchText.lowercased()
        })

        someView.tableView.reloadData()
    }
}

extension OngoingsViewController: LoaderManager {
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
