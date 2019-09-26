//
//  MatchCell.swift
//  Tinder
//
//  Created by Cory Kim on 2019/09/26.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class MatchCell: LBTAListCell<Match> {
    
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "ms1"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "Username Here", font: .systemFont(ofSize: 14, weight: .semibold), textColor: #colorLiteral(red: 0.2229189277, green: 0.2188481092, blue: 0.2260057628, alpha: 1), textAlignment: .center, numberOfLines: 2)
    
    override var item: Match! {
        didSet {
            usernameLabel.text = item.name
            profileImageView.sd_setImage(with: URL(string: item.profileImageUrl))
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        profileImageView.constrainWidth(80)
        profileImageView.constrainHeight(80)
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 80 / 2
        
        // stack(profileImageView)
        
        stack(stack(profileImageView, alignment: .center), usernameLabel)
    }
}
