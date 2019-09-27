//
//  MatchesHeader.swift
//  Tinder
//
//  Created by Cory Kim on 2019/09/27.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class MatchesHeader: UICollectionReusableView {
    
    let newMatchedLabel = UILabel(text: "New Matches", font: .systemFont(ofSize: 18, weight: .bold), textColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    
    let matchesHorizontalController = NewMatchesHorizontalController()
    
    let messagesLabel = UILabel(text: "Messages", font: .systemFont(ofSize: 18, weight: .bold), textColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(stack(newMatchedLabel).padLeft(16).withHeight(36),
              matchesHorizontalController.view.withHeight(120),
              stack(messagesLabel).padLeft(16).withHeight(28),
              spacing: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
