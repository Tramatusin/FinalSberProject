//
//  ChapterOfMangaTableViewCell.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 19.08.2021.
//

import UIKit

class ChapterOfMangaTableViewCell: UITableViewCell {
    
    static let identifier = "mangaCellId"
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var viewForGradient: GradientView = {
        let gradView = GradientView()
        gradView.translatesAutoresizingMaskIntoConstraints = false
        gradView.layer.cornerRadius = 12
        gradView.clipsToBounds = true
        return gradView
    }()

    lazy var labelForChapter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "239 глава"
        label.font = UIFont(name: "SFProText-Light", size: 10)
        return label
    }()
    
    lazy var imageOfCheckRead: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupConstraint(){
        addSubview(shadowView)
        viewForGradient.addSubview(labelForChapter)
        shadowView.addSubview(viewForGradient)
        shadowView.addSubview(imageOfCheckRead)
        
        NSLayoutConstraint.activate([
            shadowView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            viewForGradient.leftAnchor.constraint(equalTo: shadowView.leftAnchor, constant: 10),
            viewForGradient.rightAnchor.constraint(lessThanOrEqualTo: imageOfCheckRead.leftAnchor, constant: -8),
            viewForGradient.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 8),
            viewForGradient.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -8),
            
            labelForChapter.leftAnchor.constraint(equalTo: viewForGradient.leftAnchor, constant: 16),
            labelForChapter.rightAnchor.constraint(equalTo: viewForGradient.rightAnchor, constant: -16),
            labelForChapter.topAnchor.constraint(equalTo: viewForGradient.topAnchor, constant: 4),
            labelForChapter.bottomAnchor.constraint(equalTo: viewForGradient.bottomAnchor, constant: -4),
            
            imageOfCheckRead.rightAnchor.constraint(equalTo: shadowView.rightAnchor, constant: -12),
            imageOfCheckRead.topAnchor.constraint(equalTo: labelForChapter.topAnchor),
            imageOfCheckRead.bottomAnchor.constraint(equalTo: labelForChapter.bottomAnchor)
        ])
    }
    
    func setupShadow(){
        shadowView.layer.cornerRadius = 20
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        setupShadow()
        setupConstraint()
    }

}
