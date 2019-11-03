//
//  RecentMessageCell.swift
//  Tinder
//
//  Created by Cory Kim on 2019/10/15.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class RecentMessageCell: LBTAListCell<RecentMessage> {
    
    let userImageView = UIImageView(image: #imageLiteral(resourceName: "kelly1"), contentMode: .scaleAspectFill)
    
    let usernameLabel = UILabel(text: "USERNAME", font: .systemFont(ofSize: 16, weight: .bold), textColor: .darkGray, numberOfLines: 1)
    
    let messageTextLabel = UILabel(text: "some texts from the most recent message from user", font: .systemFont(ofSize: 14), textColor: .gray, textAlignment: .left, numberOfLines: 2)
    
    
    override var item: RecentMessage! {
        didSet {
            userImageView.sd_setImage(with: URL(string: item.profileImageUrl), completed: nil)
            usernameLabel.text = item.name
            messageTextLabel.text = item.text
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        userImageView.layer.cornerRadius = 84 / 2
        
        hstack(userImageView.withWidth(84).withHeight(84),
               stack(usernameLabel, messageTextLabel),
               spacing: 16,
               alignment: .center
               ).padLeft(16).padRight(16)
        
        addSeparatorView(leadingAnchor: usernameLabel.leadingAnchor)
    }
}
