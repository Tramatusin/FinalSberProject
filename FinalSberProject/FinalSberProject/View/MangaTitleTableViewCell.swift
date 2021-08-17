//
//  MangaTitleTableViewCell.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation
import UIKit

class MangaTitleTableViewCell: UITableViewCell{
    
    lazy var viewForItems: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageOfTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "solo.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    lazy var labelOfTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 14)
        label.textColor = .black
        label.text = "Поднятие уровня в одиночку dsfsnlnsen fnwefonownwpn"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelOfTags: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "боевик,магия,красавец"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Light", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var labelOfCountChapters: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "294 главы"
        label.font = UIFont(name: "SFProText-Light", size: 10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelForRaiting: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "R: 4.39"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonForFavourite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.circle.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupConstraint(){
        addSubview(viewForItems)
        viewForItems.addSubview(labelOfTitle)
        viewForItems.addSubview(labelOfTags)
        viewForItems.addSubview(gradientView)
        viewForItems.addSubview(imageOfTitle)
        viewForItems.addSubview(buttonForFavourite)
        viewForItems.addSubview(labelForRaiting)
        gradientView.addSubview(labelOfCountChapters)
        
        NSLayoutConstraint.activate([
            viewForItems.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            viewForItems.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            viewForItems.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            viewForItems.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            imageOfTitle.topAnchor.constraint(equalTo: viewForItems.topAnchor, constant: 8),
            imageOfTitle.bottomAnchor.constraint(equalTo: viewForItems.bottomAnchor, constant: -8),
            imageOfTitle.leftAnchor.constraint(equalTo: viewForItems.leftAnchor, constant: 8),
            imageOfTitle.heightAnchor.constraint(equalToConstant: 120),
            imageOfTitle.widthAnchor.constraint(equalToConstant: 80),
            
            labelOfTitle.topAnchor.constraint(equalTo: imageOfTitle.topAnchor),
            labelOfTitle.leftAnchor.constraint(equalTo: imageOfTitle.rightAnchor, constant: 13),
            labelOfTitle.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8),
            
            labelForRaiting.rightAnchor.constraint(equalTo: buttonForFavourite.rightAnchor),
            labelForRaiting.leftAnchor.constraint(equalTo: labelOfTitle.rightAnchor, constant: 4),
            labelForRaiting.topAnchor.constraint(equalTo: labelOfTitle.topAnchor),
            
            labelOfTags.rightAnchor.constraint(equalTo: labelOfTitle.rightAnchor),
            labelOfTags.leftAnchor.constraint(equalTo: labelOfTitle.leftAnchor),
            labelOfTags.topAnchor.constraint(equalTo: labelOfTitle.bottomAnchor),

            gradientView.leftAnchor.constraint(equalTo: labelOfTitle.leftAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageOfTitle.bottomAnchor),
            //gradientView.widthAnchor.constraint(equalToConstant: 80),
            //gradientView.heightAnchor.constraint(equalToConstant: 23),
            
            labelOfCountChapters.leftAnchor.constraint(equalTo: gradientView.leftAnchor, constant: 24),
            labelOfCountChapters.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 8),
            labelOfCountChapters.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -8),
            labelOfCountChapters.rightAnchor.constraint(equalTo: gradientView.rightAnchor, constant: -24),

            buttonForFavourite.rightAnchor.constraint(equalTo: viewForItems.rightAnchor, constant: -8),
            buttonForFavourite.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
            buttonForFavourite.topAnchor.constraint(equalTo: gradientView.topAnchor),
            buttonForFavourite.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupGradientView(){
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.frame = gradientView.bounds
        gradientView.layer.insertSublayer(layer0, at:0)
    }
    
    func setupCellAndShadow(){
        self.viewForItems.layer.cornerRadius = 20
        self.viewForItems.clipsToBounds = false
        viewForItems.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewForItems.layer.shadowOpacity = 1
        viewForItems.layer.shadowRadius = 7
        viewForItems.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        self.selectionStyle = .none
        setupCellAndShadow()
        setupGradientView()
        setupConstraint()
    }
}
