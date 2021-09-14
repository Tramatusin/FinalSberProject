//
//  GradientView.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 19.08.2021.
//

import Foundation
import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupGradient() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1).cgColor,
            UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.frame = self.bounds
        self.layer.insertSublayer(layer0, at: 0)
    }

    func setupReadGradient() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.949, green: 0.6, blue: 0.29, alpha: 1).cgColor,
          UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.frame = self.bounds
        self.layer.insertSublayer(layer0, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
    }

}
