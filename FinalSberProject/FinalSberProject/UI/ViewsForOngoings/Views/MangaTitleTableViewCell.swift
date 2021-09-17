//
//  MangaTitleTableViewCell.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import Foundation
import UIKit

class MangaTitleTableViewCell: UITableViewCell {

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
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
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

    lazy var gradientView: GradientView = {
        let view = GradientView()
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
        label.textColor = UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1)
        label.text = "R: 4.39 ✭"
        label.textAlignment = .right
        label.font = UIFont(name: "SFProText-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var buttonForFavourite: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "book.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    func setupConstraint() {
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
            labelOfTitle.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -50),
            labelOfTitle.rightAnchor.constraint(equalTo: labelForRaiting.leftAnchor, constant: -4),

            labelForRaiting.rightAnchor.constraint(equalTo: buttonForFavourite.rightAnchor),
            labelForRaiting.topAnchor.constraint(equalTo: labelOfTitle.topAnchor),

            labelOfTags.rightAnchor.constraint(equalTo: labelOfTitle.rightAnchor),
            labelOfTags.leftAnchor.constraint(equalTo: labelOfTitle.leftAnchor),
            labelOfTags.topAnchor.constraint(equalTo: labelOfTitle.bottomAnchor, constant: 2),

            gradientView.leftAnchor.constraint(equalTo: labelOfTitle.leftAnchor),
            gradientView.bottomAnchor.constraint(equalTo: imageOfTitle.bottomAnchor),

            labelOfCountChapters.leftAnchor.constraint(equalTo: gradientView.leftAnchor, constant: 32),
            labelOfCountChapters.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 8),
            labelOfCountChapters.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -8),
            labelOfCountChapters.rightAnchor.constraint(equalTo: gradientView.rightAnchor, constant: -32),

            buttonForFavourite.rightAnchor.constraint(equalTo: viewForItems.rightAnchor, constant: -8),
            buttonForFavourite.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
            buttonForFavourite.widthAnchor.constraint(equalToConstant: 35),
            buttonForFavourite.heightAnchor.constraint(equalTo: buttonForFavourite.widthAnchor)
        ])
    }

    func configureCell(name: String, data: Data, tags: [String], chaptersCount: Int, raiting: String) {
        let resChapterCount = chaptersCount == 0 ? "-" : "\(chaptersCount)"
        labelOfTitle.text = name
        imageOfTitle.image = UIImage(data: data)
        labelOfTags.text = tags.joined(separator: ", ")
        labelOfCountChapters.text = "\(resChapterCount) глав"
        labelForRaiting.text = "R: \(raiting) ✭"
    }

    func setupCellAndShadow() {
        viewForItems.layer.cornerRadius = 20
        viewForItems.layer.masksToBounds = false
        viewForItems.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewForItems.layer.shadowOpacity = 1
        viewForItems.layer.shadowRadius = 7
        viewForItems.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewForItems.layer.shadowPath = UIBezierPath(roundedRect: viewForItems.bounds, cornerRadius: 20).cgPath
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        self.selectionStyle = .none
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellAndShadow()
    }
}
