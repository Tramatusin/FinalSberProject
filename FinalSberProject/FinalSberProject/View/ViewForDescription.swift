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
        label.text = "Описание"
        label.font = UIFont(name: "SFProText-Medium", size: 19)
        label.sizeToFit()
        label.accessibilityIdentifier = "description"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    lazy var labelForDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupConstraint() {
        addSubview(labelForTitle)
        addSubview(labelForDescription)

        NSLayoutConstraint.activate([
            labelForTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            labelForTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            labelForTitle.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            labelForTitle.bottomAnchor.constraint(equalTo: labelForDescription.topAnchor, constant: -6),

//            labelForDescription.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            labelForDescription.leftAnchor.constraint(equalTo: labelForTitle.leftAnchor),
            labelForDescription.rightAnchor.constraint(equalTo: labelForTitle.rightAnchor),
            labelForDescription.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -4)
//            labelForDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDataInView(description: String) {
        labelForDescription.text = description
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        setupConstraint()
    }
}
