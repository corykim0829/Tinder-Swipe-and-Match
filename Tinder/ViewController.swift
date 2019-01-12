//
//  ViewController.swift
//  Tinder
//
//  Created by Cory Kim on 11/01/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subviews = [UIColor.gray, .darkGray, .black].map
        { (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        
        let topStackView = UIStackView(arrangedSubviews: subviews)
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let bottomSubviews = [UIColor.red, .yellow, .purple, .cyan, .orange].map
        { (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        
        let bottomStackView = UIStackView(arrangedSubviews: bottomSubviews)
        bottomStackView.distribution = .fillEqually
        bottomStackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, bottomStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
        
        overallStackView.fillSuperview()
    }
}

