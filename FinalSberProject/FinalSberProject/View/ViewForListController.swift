//
//  ViewForListController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation
import UIKit

class ViewForListController: UIView, UITableViewDelegate{
    var tapOnChooseType: (()->())?
    
    lazy var selectorMangaType: UISegmentedControl = {
        let selector = UISegmentedControl(items: ["Манга","Манхва","Маньхуа"])
        selector.addTarget(self, action: #selector(didChooseMangaType), for: .touchUpInside)
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MangaTitleTableViewCell.self, forCellReuseIdentifier: "mangaCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    func setupConstraint(){
        addSubview(tableView)
        addSubview(selectorMangaType)
        
        NSLayoutConstraint.activate([
            selectorMangaType.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            selectorMangaType.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -8),
            selectorMangaType.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8),
            
            tableView.topAnchor.constraint(equalTo: selectorMangaType.bottomAnchor,constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didChooseMangaType(){
        tapOnChooseType?()
    }
}
