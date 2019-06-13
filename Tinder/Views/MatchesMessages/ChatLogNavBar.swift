//
//  ChatLogNavBar.swift
//  Tinder
//
//  Created by Cory Kim on 12/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class ChatLogNavBar: UIView {
    
    let userProfileImageView = CircularImageView(width: 44, image: #imageLiteral(resourceName: "gp3"))
    let usernameLabel = UILabel(text: "Kiki", font: .systemFont(ofSize: 16))
    let backButton = UIButton(image: #imageLiteral(resourceName: "back"), tintColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    let flagButton = UIButton(image: #imageLiteral(resourceName: "flag"), tintColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    
    fileprivate let match: Match
    
    init(match: Match) {
        
        self.match = match
        
        userProfileImageView.sd_setImage(with: URL(string: match.profileImageUrl))
        usernameLabel.text = match.name
        
        super.init(frame: .zero)
        backgroundColor = .white
        
        setupShadow(opacity: 0.2, radius: 8, offset: .init(width: 0, height: 10), color: .init(white: 0, alpha: 0.3))
        
        //        userProfileImageView.constrainWidth(44)
        //        userProfileImageView.constrainHeight(44)
        //        userProfileImageView.clipsToBounds = true
        //        userProfileImageView.layer.cornerRadius = 44 / 2
        
        let middleStack = hstack(
            stack(
                userProfileImageView,
                usernameLabel,
                spacing: 8,
                alignment: .center),
            alignment: .center
        )
        
        hstack(
            backButton.withWidth(50),
            middleStack,
            flagButton
            ).withMargins(.init(top: 0, left: 4, bottom: 0, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
