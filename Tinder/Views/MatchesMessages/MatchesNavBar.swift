//
//  MatchesNavBar.swift
//  Tinder
//
//  Created by Cory Kim on 09/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class MatchesNavBar: UIView {
    
    let backButton = UIButton(image: #imageLiteral(resourceName: "app_icon"), tintColor: #colorLiteral(red: 0.8460934758, green: 0.8749427795, blue: 0.904964745, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        // if we don't set up background color, shadow doesn't show up
        
        let iconImageView = UIImageView(image: #imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        iconImageView.tintColor = #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1)
        let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 24), textColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1), textAlignment: .center)
        let feedLabel = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 24), textColor: .lightGray, textAlignment: .center)
        
        stack(iconImageView.withHeight(42),
                     hstack(messagesLabel, feedLabel, distribution: .fillEqually)).padTop(10)
        
        setupShadow(opacity: 0.2, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.3))
        
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 14, left: 16, bottom: 0, right: 0), size: .init(width: 38, height: 38))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
