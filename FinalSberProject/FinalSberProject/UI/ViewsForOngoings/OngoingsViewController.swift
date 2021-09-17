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
    private let networkDataManager: JsonDataManager
    private let userDef: UserDefautlsService
    private let coreDataManager: CoreDataManager
    private let refreshControl = UIRefreshControl()

    init(dataManager: JsonDataManager, userDefManager: UserDefautlsService,
         coreDataManager: CoreDataManager) {
        self.networkDataManager = dataManager
        self.userDef = userDefManager
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = someView
        navigationItem.title = "Онгоинги"
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserDefaults()
        setupButtonTitleAfterStart()
        someView.tableView.refreshControl = refreshControl
        displayLoader()
        setCurrentMangaListAfterButtonTap(pageType: ongoingPageType, listOfOngoing: setMangaList())
        tapOnButtons()
    }

    @objc func refresh(_ sender: Any) {
        displayLoader()
        load(urlStr: ongoingPageType.rawValue)
        someView.manhvaBut.isHidden = false
        someView.manhuyaBut.isHidden = false
        someView.mangaBut.setTitle("Манга", for: .normal)
        someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
        someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
        refreshControl.endRefreshing()
    }

    private func tapOnButtons() {
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

    private func setCurrentMangaListAfterButtonTap(pageType: TypeOngoings, listOfOngoing: [NetManga]) {
        self.ongoingPageType = pageType
        userDef.setDataInUserDefaults(pageType: pageType, key: "type")
        if listOfOngoing.isEmpty {
            self.displayLoader()
            load(urlStr: pageType.rawValue)
            return
        }
        self.someView.tableView.reloadData()
    }

    private func setMangaList() -> [NetManga] {
        switch ongoingPageType {
        case .manga:
            return mangaList
        case .manhva:
            return manhvaList
        case .manhuya:
            return manhuyaList
        }
    }

    private func checkUserDefaults() {
        if let pageType = userDef.readDataOnUserDefaults(key: "type") {
            ongoingPageType = pageType
        }
    }

    private func setupButtonTitleAfterStart() {
        switch ongoingPageType {
        case .manga:
            self.someView.mangaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        case .manhva:
            self.someView.manhvaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        case .manhuya:
            self.someView.manhuyaBut.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 16)
        }
    }
}

extension OngoingsViewController {
    private func load(urlStr: String) {
        let loadQueue = DispatchQueue(label: "load")
        loadQueue.async { [weak self] in
            guard let url = URL(string: urlStr),
                  let self = self else { return }
            self.networkDataManager.deserializeMangaData(url: url) { items in
                switch items {
                case .failure(let error):
                    let resManga = self.coreDataManager.castLocalMangaToNetManga()
                    let errorMessage = "Ошибка при работе с сетью \(error)"
                    self.mangaList = resManga
                    self.ongoingPageType = .manga
                    DispatchQueue.main.async {
                        self.someView.tableView.refreshControl = self.refreshControl
                        self.someView.manhvaBut.isHidden = true
                        self.someView.manhuyaBut.isHidden = true
                        self.someView.mangaBut.setTitle("Офлайн", for: .normal)
                        self.someView.mangaBut.titleLabel?.font =
                            UIFont(name: "SFProText-Medium", size: 16)
                    }
                    self.endLoad()
                    ShowErrors
                        .showErrorMessage(message: errorMessage, on: self)
                case .success(let mangaData):
                    switch self.ongoingPageType {
                    case .manga:
                        self.mangaList = mangaData
                    case .manhva:
                        self.manhvaList = mangaData
                    case .manhuya:
                        self.manhuyaList = mangaData
                    }
                    self.setDataInCoreData(mangas: mangaData)
                    self.offRefreshControll()
                    self.endLoad()
                }
            }
        }
    }

    private func endLoad() {
        DispatchQueue.main.async {
            self.someView.tableView.reloadData()
            self.disapearLoader()
        }
    }

    private func offRefreshControll() {
        DispatchQueue.main.async {
            self.someView.tableView.refreshControl = nil
        }
    }

    private func setDataInCoreData(mangas: [NetManga]) {
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
        cell.accessibilityLabel = "cell_\(indexPath.row)"

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
        navigationController?.pushViewController(currentMangaVC, animated: true)
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
