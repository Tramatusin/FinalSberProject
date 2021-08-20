//
//  MangaViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import UIKit

class MangaViewController: UIViewController {
    
    let mangaView = ViewForSelectedManga()
    let countOfChapters = ["222","223"]

    override func loadView() {
        super.loadView()
        view = mangaView
        mangaView.tableView.delegate = self
        mangaView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Манга"
    }

}

extension MangaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countOfChapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChapterOfMangaTableViewCell.identifier, for: indexPath) as! ChapterOfMangaTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
