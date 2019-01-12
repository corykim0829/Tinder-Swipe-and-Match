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
        
        let topStackView = TopNavigationStackView()
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let buttonsStackView = HomeBottomControlsStackView()
        
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonsStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
        
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}

