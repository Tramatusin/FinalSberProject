//
//  LoadingViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 24.08.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var images: [UIImage?] = [
        UIImage(named: "0.png"),UIImage(named: "1.png"),UIImage(named: "2.png"),
        UIImage(named: "3.png"),UIImage(named: "4.png"),UIImage(named: "5.png"),
        UIImage(named: "6.png"),UIImage(named: "7.png"),UIImage(named: "8.png"),
        UIImage(named: "9.png"),UIImage(named: "10.png")]

    lazy var imageOfAnimation: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .orange
        imageView.contentMode = .center
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageOfAnimation)
        setupAnimation()
        setupConst()
    }
    
    func setupConst(){
        view.addSubview(imageOfAnimation)
        
        imageOfAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageOfAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupAnimation(){
        imageOfAnimation.animationRepeatCount = 30
        imageOfAnimation.animationDuration = 2.0
        UIImage.animatedImage(with: setImages(), duration: 2.0)
        imageOfAnimation.animationRepeatCount = .max
        imageOfAnimation.animationImages = setImages()
        imageOfAnimation.startAnimating()
    }
    
    func setImages()->[UIImage]{
        var notNilImages: [UIImage] = []
        for image in images{
            guard let curImage = image else { return notNilImages}
            notNilImages.append(curImage)
        }
        return notNilImages
    }
    
    //TODO added normal constraint
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        imageOfAnimation.center.x = view.bounds.width/4
//        imageOfAnimation.center.y = view.bounds.height/4
    }
    
}
