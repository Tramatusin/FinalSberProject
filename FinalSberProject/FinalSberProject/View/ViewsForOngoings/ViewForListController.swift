//
//  ViewForListController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation
import UIKit

class ViewForListController: UIView, UITableViewDelegate{
    
    var tapOnManhvaBut: (()->())?
    var tapOnMangaBut: (()->())?
    var tapOnManhuyaBut: (()->())?

    lazy var viewForSegmentControl: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewForButtons: UIView = {
        let gradView = UIView()
        gradView.translatesAutoresizingMaskIntoConstraints = false
        return gradView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Поиск по названию"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var mangaBut: GradientButton = {
        let button = GradientButton()
        button.setTitle("Манга", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
        button.addTarget(self, action: #selector(didTapOnMangaBut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var manhvaBut: GradientButton = {
        let button = GradientButton()
        button.setTitle("Манхва", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
        button.addTarget(self, action: #selector(didTapOnManhvaBut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var manhuyaBut: GradientButton = {
        let button = GradientButton()
        button.setTitle("Маньхуа", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Light", size: 14)
        button.addTarget(self, action: #selector(didTapOnManhuyaBut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        setupRadius()
    }
    
    func setupConstraint(){
        addSubview(tableView)
        addSubview(viewForButtons)
        viewForButtons.addSubview(mangaBut)
        viewForButtons.addSubview(manhvaBut)
        viewForButtons.addSubview(manhuyaBut)
        
        NSLayoutConstraint.activate([
            viewForButtons.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            viewForButtons.rightAnchor.constraint(equalTo: rightAnchor,constant: -8),
            viewForButtons.leftAnchor.constraint(equalTo: leftAnchor,constant: 8),
            viewForButtons.heightAnchor.constraint(equalToConstant: 50),
            
            mangaBut.leftAnchor.constraint(equalTo: viewForButtons.leftAnchor),
            mangaBut.widthAnchor.constraint(equalTo: viewForButtons.widthAnchor, multiplier: 0.3),
            mangaBut.centerYAnchor.constraint(equalTo: viewForButtons.centerYAnchor),
            
            manhvaBut.centerXAnchor.constraint(equalTo: viewForButtons.centerXAnchor),
            manhvaBut.widthAnchor.constraint(equalTo: mangaBut.widthAnchor),
            manhvaBut.heightAnchor.constraint(equalTo: mangaBut.heightAnchor),
            manhvaBut.centerYAnchor.constraint(equalTo: mangaBut.centerYAnchor),
            
            manhuyaBut.rightAnchor.constraint(equalTo: viewForButtons.rightAnchor),
            manhuyaBut.widthAnchor.constraint(equalTo: mangaBut.widthAnchor),
            manhuyaBut.heightAnchor.constraint(equalTo: mangaBut.heightAnchor),
            manhuyaBut.centerYAnchor.constraint(equalTo: mangaBut.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: viewForButtons.bottomAnchor,constant: 4),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func setupRadius(){
        mangaBut.clipsToBounds = true
        manhvaBut.clipsToBounds = true
        manhuyaBut.clipsToBounds = true
        mangaBut.layer.cornerRadius = 8
        manhvaBut.layer.cornerRadius = 8
        manhuyaBut.layer.cornerRadius = 8
    }
    
    @objc func didTapOnMangaBut(){
        tapOnMangaBut?()
    }
    
    @objc func didTapOnManhvaBut(){
        tapOnManhvaBut?()
    }
    
    @objc func didTapOnManhuyaBut(){
        tapOnManhuyaBut?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
