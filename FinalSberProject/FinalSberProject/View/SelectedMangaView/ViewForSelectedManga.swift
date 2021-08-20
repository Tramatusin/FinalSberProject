//
//  ViewForSelectedManga.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import UIKit

class ViewForSelectedManga: UIView {
    
    lazy var imageViewForTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "solo.jpg")
        imageView.contentMode = .top
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(ChapterOfMangaTableViewCell.self, forCellReuseIdentifier: ChapterOfMangaTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var viewForItems: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var labelForManagName: UILabel = {
        let label = UILabel()
        label.text = "SoloLeveling"
        label.font = UIFont(name: "SFProText-Medium", size: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonForFullDescription: UIButton = {
        let button = UIButton()
        button.setTitle("Описание", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint(){
        addSubview(imageViewForTitle)
        addSubview(tableView)
        addSubview(viewForItems)
        viewForItems.addSubview(labelForManagName)
        viewForItems.addSubview(buttonForFullDescription)
        
        NSLayoutConstraint.activate([
            imageViewForTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageViewForTitle.leftAnchor.constraint(equalTo: leftAnchor),
            imageViewForTitle.rightAnchor.constraint(equalTo: rightAnchor),
            imageViewForTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            tableView.topAnchor.constraint(equalTo: viewForItems.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelForManagName.leftAnchor.constraint(equalTo: viewForItems.leftAnchor, constant: 4),
            labelForManagName.topAnchor.constraint(equalTo: viewForItems.topAnchor, constant: 4),
            labelForManagName.rightAnchor.constraint(lessThanOrEqualTo: buttonForFullDescription.leftAnchor, constant: -4),
            labelForManagName.bottomAnchor.constraint(equalTo: viewForItems.bottomAnchor, constant: -4),
            
            viewForItems.rightAnchor.constraint(equalTo: rightAnchor),
            viewForItems.leftAnchor.constraint(equalTo: leftAnchor),
            //viewForItems.heightAnchor.constraint(equalToConstant: 35),
            viewForItems.centerYAnchor.constraint(equalTo: imageViewForTitle.bottomAnchor),
            
            buttonForFullDescription.topAnchor.constraint(equalTo: viewForItems.topAnchor, constant: 4),
            buttonForFullDescription.rightAnchor.constraint(equalTo: viewForItems.rightAnchor, constant: -8),
            buttonForFullDescription.bottomAnchor.constraint(equalTo: labelForManagName.bottomAnchor)
        ])
    }
    
    func drawView(){
        let path = UIBezierPath(roundedRect: viewForItems.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 16, height: 16))
        let someLayer = CAShapeLayer()
        someLayer.frame = viewForItems.bounds
        someLayer.path = path.cgPath
        viewForItems.layer.mask = someLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        drawView()
    }

}
