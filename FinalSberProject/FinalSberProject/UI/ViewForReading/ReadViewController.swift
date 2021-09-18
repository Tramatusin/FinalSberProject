//
//  ReadViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 23.08.2021.
//

import UIKit

class ReadViewController: UIViewController {

    var currentManga: NetManga?
    var currentChapter: Chapters?
    let urlForPage = "http://hsemanga.ddns.net:7000/getmanga/chapter/"
    var pages: [Data]?
    let readView = ViewForPages()
    let loadingVC = LoadingViewController()
    let dataManager = JsonDataManagerImp(session: URLSession.shared, jsonBuilder: JSONBuildManagerImp())
    var curImage: UIImage?

    override func loadView() {
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

    // Метод загружающий страницы и отображающий ошибки
    func loadPages() {
        guard let code = currentManga?.code,
              let chapter = currentChapter,
              let url = URL(string: urlForPage) else { return }
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.dataManager.deserealizePagesData(code: code, chapterManga: chapter, url: url, completion: { result in
                switch result {
                case.failure(let error):
                    let message: String
                    switch error {
                    case .warningRequest(message: let mes):
                        message = "Ошибка с загрузкой данных, попробуйте снова \(mes)"
                    case .warningWithParseJson(message: let mes):
                        message = """
                            Ошибка с получшение страниц, это значит,
                            что выбранная вами манга сейчас недоступна
                            Error: \(mes)
                        """
                    case .warningResponse(message: let mes):
                        message = "Ошибка с запросом \(mes)"
                    }
                    DispatchQueue.main.async {
                        self.disapearLoader()
                    }
                    ShowErrors
                        .showErrorMessage(message: message, on: self)
                case .success(let pages):
                    DispatchQueue.main.async {
                        self.pages = pages
                        self.readView.tableViewForPages.reloadData()
                        self.disapearLoader()
                    }
                }
            })
        }
    }

}

// MARK: - Методы таблицы

extension ReadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pages?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: PagesTableViewCell.identifier, for: indexPath)
                as? PagesTableViewCell
        else {
            return tableView.dequeueReusableCell(withIdentifier: PagesTableViewCell.identifier, for: indexPath)
        }
        guard let pages = pages?[indexPath.row],
              let image = UIImage(data: pages)
        else { return cell }
        curImage = image
        cell.configureCell(pageData: image, numberOfPage: indexPath.row)
        cell.backgroundColor = .orange
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let pages = pages?[indexPath.row],
              let image = UIImage(data: pages) else { return CGFloat(1000) }
        let imageRatio = image.size.width / image.size.height
        return tableView.frame.width / imageRatio
    }

}

// MARK: - Методы лоадера

extension ReadViewController: LoaderManager {

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
