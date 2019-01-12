//
//  HomeBottomControlsStackView.swift
//  Tinder
//
//  Created by Cory Kim on 12/01/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let subviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
        
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
