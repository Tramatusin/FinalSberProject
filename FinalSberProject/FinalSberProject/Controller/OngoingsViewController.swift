//
//  ViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import UIKit

class OngoingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mangaList: [Manga]?
    
    override func loadView() {
        let someView = ViewForListController()
        super.loadView()
        view = someView
        someView.tableView.dataSource = self
        someView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension OngoingsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mangaList?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mangaCell", for: indexPath) as! MangaTitleTableViewCell
        cell.lbl.text = mangaList?[indexPath.row].title
        return cell
    }
}
