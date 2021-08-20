//
//  ViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import UIKit

class OngoingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mangaList: [Manga]?
    let someView = ViewForListController()
    let nm = NetworkManagerImp()
    
    override func loadView() {
        super.loadView()
        view = someView
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlStr = URL(string: "http://hsemanga.ddns.net:7000/catalogues/manga/") else {
            return
        }
        nm.getMangaList(url: urlStr) { items in
            print(items)
        }
        navigationItem.title = "Онгоинги"
    }
    
//    func setupSearchBar(){(
//        //
//    }
    
}

extension OngoingsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mangaList?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTitleTableViewCell
        //cell.lbl.text = mangaList?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MangaViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
