//
//  ViewForPages.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 23.08.2021.
//

import UIKit

class ViewForPages: UIView {

    lazy var tableViewForPages: UITableView = {
        let tableView = UITableView()
        tableView.register(PagesTableViewCell.self, forCellReuseIdentifier: PagesTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint(){
        addSubview(tableViewForPages)
        
        NSLayoutConstraint.activate([
            tableViewForPages.leftAnchor.constraint(equalTo: leftAnchor),
            tableViewForPages.rightAnchor.constraint(equalTo: rightAnchor),
            tableViewForPages.topAnchor.constraint(equalTo: topAnchor),
            tableViewForPages.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
