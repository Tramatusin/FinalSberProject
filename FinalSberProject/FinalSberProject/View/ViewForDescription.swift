//
//  ViewForDescription.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 22.08.2021.
//

import Foundation
import UIKit

class ViewForDescription: UIView{
    
    lazy var labelForTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание"
        label.font = UIFont(name: "SFProText-Medium", size: 17)
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelForDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 14)
        label.text = "Последние слова, произнесённые Королем Пиратов Гол Д. Роджером перед казнью, вдохновили многих выйти в море: «Мои сокровища? Я завещаю их тому, кто сможет их найти. Ищите! Я все оставил в одном месте!». Лишённые сна и покоя люди ринулись на Гранд Лайн, самое опасное место в мире. Так началась великая эра пиратов... Но с каждым годом романтиков становилось все меньше, их постепенно вытесняли прагматичные пираты-разбойники, которым награбленное добро было куда ближе, чем какие-то «никчёмные мечты». Но вот, одним прекрасным днем, семнадцатилетний Монки Д. Луффи исполнил заветную мечту детства — отправился в море. Его цель — ни много, ни мало стать новым Королём Пиратов. За достаточно короткий срок юному капитану удаётся собрать команду, состоящую из не менее амбициозных искателей приключений. И пусть ими движут совершенно разные устремления, главное, этим ребятам важны не столько деньги и слава, сколько куда более ценное – принципы и верность друзьям. И ещё – служение Мечте. Что же, пока по Гранд Лайн плавают такие люди, Великая Эра Пиратов всегда будет с нами!"
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupConstraint(){
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
    
    func setDataInView(description: String){
        labelForDescription.text = description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        setupConstraint()
    }
}
