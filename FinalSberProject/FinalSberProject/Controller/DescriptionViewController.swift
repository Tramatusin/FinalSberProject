//
//  DescriptionViewController.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 22.08.2021.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var descripView = ViewForDescription()
    
    override func loadView() {
        super.loadView()
        view = descripView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
