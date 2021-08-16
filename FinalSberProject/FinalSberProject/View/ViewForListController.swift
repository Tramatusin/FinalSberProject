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
        let selector = UISegmentedControl()
        selector.addTarget(self, action: #selector(didChooseMangaType), for: .touchUpInside)
        return selector
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MangaTitleTableViewCell.self, forCellReuseIdentifier: "mangaCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    func setupConstraint(){
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didChooseMangaType(){
        tapOnChooseType?()
    }
}
