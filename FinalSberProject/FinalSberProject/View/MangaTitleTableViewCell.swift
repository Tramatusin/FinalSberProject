//
//  MangaTitleTableViewCell.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation
import UIKit

class MangaTitleTableViewCell: UITableViewCell{
//    lazy var imageOfTitle: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .
//        return imageView
//    }()
    
    lazy var lbl: UILabel = {
        let label = UILabel()
        label.text = "ghbdtn"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupConstraint(){
        addSubview(lbl)
        
        NSLayoutConstraint.activate([
            lbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            lbl.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }
}
