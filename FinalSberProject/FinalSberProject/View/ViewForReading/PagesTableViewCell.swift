//
//  PagesTableViewCell.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 23.08.2021.
//

import UIKit

class PagesTableViewCell: UITableViewCell {

    static let identifier = "ReadCellID"

    lazy var imageViewForPage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    lazy var labelForNumberPage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func configureCell(pageData: UIImage, numberOfPage: Int) {
        imageViewForPage.image = pageData
        labelForNumberPage.text = "Page \(numberOfPage + 1)"
    }

    func setupConstraints() {
        addSubview(imageViewForPage)
        gradientView.addSubview(labelForNumberPage)
        imageViewForPage.addSubview(gradientView)

        NSLayoutConstraint.activate([
            imageViewForPage.leftAnchor.constraint(equalTo: leftAnchor),
            imageViewForPage.rightAnchor.constraint(equalTo: rightAnchor),
            imageViewForPage.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageViewForPage.topAnchor.constraint(equalTo: topAnchor),

            labelForNumberPage.leftAnchor.constraint(equalTo: gradientView.leftAnchor, constant: 4),
            labelForNumberPage.rightAnchor.constraint(equalTo: gradientView.rightAnchor, constant: -4),
            labelForNumberPage.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 2),
            labelForNumberPage.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -2),

            gradientView.rightAnchor.constraint(equalTo: imageViewForPage.rightAnchor, constant: -12),
            gradientView.topAnchor.constraint(equalTo: topAnchor, constant: 14)
        ])
    }

    func setupGradient() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1).cgColor,
          UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.frame = self.bounds
        gradientView.layer.insertSublayer(layer0, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        setupGradient()
    }
}
