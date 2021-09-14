//
//  MangaViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import UIKit

class MangaViewController: UIViewController {

    let mangaView = ViewForSelectedManga()
    var currentManga: NetManga?

    override func loadView() {
        mangaView.configureView(currentManga: currentManga)
        view = mangaView
        mangaView.tableView.delegate = self
        mangaView.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTapOnDescrip()
        navigationItem.title = currentManga?.name
    }

    func setTapOnDescrip() {
        mangaView.tapOnDecription = { [weak self] in
            let descriptionVC = DescriptionViewController()
            descriptionVC.descripView.setDataInView(description: self?.currentManga?.description ?? " ")
            self?.present(descriptionVC, animated: true, completion: nil)
        }
    }

}

extension MangaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentManga?.chapters?.count ?? 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: ChapterOfMangaTableViewCell.identifier, for: indexPath)
            as? ChapterOfMangaTableViewCell
        else {
            return tableView.dequeueReusableCell(withIdentifier: ChapterOfMangaTableViewCell.identifier, for: indexPath)
        }
        guard let indexManga = currentManga?.chapters?[indexPath.row],
              let volume = indexManga.volume,
              let chapter = indexManga.chapter,
              let name = indexManga.name else { return cell }
        cell.configureCell(volume: volume, chapter: chapter, nameChapter: name)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedChapter = currentManga?.chapters?[indexPath.row] else { return }
        let readVC = ReadViewController()
        readVC.currentManga = currentManga
        readVC.currentChapter = selectedChapter
        navigationController?.pushViewController(readVC, animated: true)
    }
}
