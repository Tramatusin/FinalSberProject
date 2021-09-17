//
//  ViewForDescription.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 22.08.2021.
//

import Foundation
import UIKit

class ViewForDescription: UIView {

    lazy var labelForTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подробности"
        label.font = UIFont(name: "SFProText-Medium", size: 19)
        label.sizeToFit()
        label.accessibilityIdentifier = "description"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    lazy var textViewForDescription: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "SFProText-Medium", size: 16)
        text.textColor = .black
        text.isEditable = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    lazy var imageOfTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var labelForRating: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 15)
        label.textColor = UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelForRatingCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 16)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelForHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 19)
        label.text = "Описание"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupConstraint() {
        addSubview(labelForTitle)
        addSubview(imageOfTitle)
        addSubview(textViewForDescription)
        addSubview(labelForRating)
        addSubview(labelForRatingCount)
        addSubview(labelForHeader)

        NSLayoutConstraint.activate([
            labelForTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            labelForTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            labelForTitle.topAnchor.constraint(equalTo: topAnchor, constant: 4),
//            labelForTitle.bottomAnchor.constraint(equalTo: labelForDescription.topAnchor, constant: -6),

            imageOfTitle.topAnchor.constraint(equalTo: labelForTitle.bottomAnchor, constant: 4),
            imageOfTitle.leftAnchor.constraint(equalTo: textViewForDescription.leftAnchor),
            imageOfTitle.widthAnchor.constraint(equalToConstant: 100),
            imageOfTitle.heightAnchor.constraint(equalToConstant: 150),

            labelForRatingCount.bottomAnchor.constraint(equalTo: imageOfTitle.bottomAnchor),
            labelForRatingCount.leftAnchor.constraint(equalTo: imageOfTitle.rightAnchor, constant: 13),
            labelForRatingCount.rightAnchor.constraint(equalTo: labelForTitle.rightAnchor),

            labelForRating.bottomAnchor.constraint(equalTo: labelForRatingCount.topAnchor,
                                                   constant: -4),
            labelForRating.leftAnchor.constraint(equalTo: labelForRatingCount.leftAnchor),

            labelForHeader.topAnchor.constraint(equalTo: imageOfTitle.bottomAnchor, constant: 8),
            labelForHeader.leftAnchor.constraint(equalTo: labelForTitle.leftAnchor),
            labelForHeader.rightAnchor.constraint(equalTo: labelForTitle.rightAnchor),

//            labelForDescription.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            textViewForDescription.topAnchor.constraint(equalTo: labelForHeader.bottomAnchor, constant: 2),
            textViewForDescription.leftAnchor.constraint(equalTo: labelForTitle.leftAnchor),
            textViewForDescription.rightAnchor.constraint(equalTo: labelForTitle.rightAnchor),
            textViewForDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
//            labelForDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDataInView(manga: NetManga) {
        textViewForDescription.text = manga.description
        guard let dataImage = manga.cover,
              let image = Data(base64Encoded: dataImage, options: .ignoreUnknownCharacters),
              let rating = manga.ratingValue,
              let ratingCount = manga.ratingCount
        else { return }
        imageOfTitle.image = UIImage(data: image)
        labelForRating.text = "Рейтинг: \(rating) ✭"
        labelForRatingCount.text = "Оценку дало: \(ratingCount) человек"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        setupConstraint()
    }
}
