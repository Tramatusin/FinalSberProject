//
//  LoadingViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 24.08.2021.
//

import UIKit

class LoadingViewController: UIViewController {

    var images: [UIImage?] = [
        UIImage(named: "0.png"), UIImage(named: "1.png"), UIImage(named: "2.png"),
        UIImage(named: "3.png"), UIImage(named: "4.png"), UIImage(named: "5.png"),
        UIImage(named: "6.png"), UIImage(named: "7.png"), UIImage(named: "8.png"),
        UIImage(named: "9.png"), UIImage(named: "10.png") ]

    lazy var labelForwWarning: UILabel = {
        let label = UILabel()
        label.text = "Если вы впервые загружаете главу, это может происходить долго, извините 🥺"
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont(name: "SFProText-Medium", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageOfAnimation: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .orange
        imageView.contentMode = .center
        imageView.sizeToFit()
        return imageView
    }()

//    lazy var label: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }

    func setupConst() {
        view.addSubview(imageOfAnimation)
        view.addSubview(labelForwWarning)

        NSLayoutConstraint.activate([
            imageOfAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOfAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            labelForwWarning.leftAnchor.constraint(equalTo: view.leftAnchor),
            labelForwWarning.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelForwWarning.topAnchor.constraint(equalTo: imageOfAnimation.bottomAnchor, constant: 6)
            // labelForwWarning.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }

    func setupAnimation() {
        imageOfAnimation.animationRepeatCount = 30
        imageOfAnimation.animationDuration = 2.0
        UIImage.animatedImage(with: setImages(), duration: 2.0)
        imageOfAnimation.animationRepeatCount = .max
        imageOfAnimation.animationImages = setImages()
        imageOfAnimation.startAnimating()
    }

    func setImages() -> [UIImage] {
        var notNilImages: [UIImage] = []
        for image in images {
            guard let curImage = image else { return notNilImages }
            notNilImages.append(curImage)
        }
        return notNilImages
    }

    // TODO: added normal constraint
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        imageOfAnimation.center.x = view.bounds.width/4
//        imageOfAnimation.center.y = view.bounds.height/4
    }

}
