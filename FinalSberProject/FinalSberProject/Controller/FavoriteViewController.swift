//
//  FavouriteViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 25.08.2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let viewForFravourite = ViewForListController()
    var favouriteManga: [Manga]?
    
    override func loadView() {
        super.loadView()
        view = viewForFravourite
        viewForFravourite.tableView.delegate = self
        viewForFravourite.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteManga?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MangaTitleTableViewCell.id, for: indexPath) as! MangaTitleTableViewCell
        guard let indexManga = favouriteManga?[indexPath.row],
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
}
