//
//  MessageCell.swift
//  Tinder
//
//  Created by Cory Kim on 27/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class MessageCell: LBTAListCell<Message> {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 18)
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    let bubbleContainer = UIView(backgroundColor: #colorLiteral(red: 0.9069489837, green: 0.9015577435, blue: 0.9110931754, alpha: 1))
    
    override var item: Message! {
        didSet {
            textView.text = item.text
            
            if item.isFromCurrentLoggedUser {
                anchoredContstraints.trailing?.isActive = true
                anchoredContstraints.leading?.isActive = false
                bubbleContainer.backgroundColor = #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1)
                textView.textColor = .white
            } else {
                anchoredContstraints.trailing?.isActive = false
                anchoredContstraints.leading?.isActive = true
                bubbleContainer.backgroundColor = #colorLiteral(red: 0.9069489837, green: 0.9015577435, blue: 0.9110931754, alpha: 1)
                textView.textColor = .black
            }
        }
    }
    
    var anchoredContstraints: AnchoredConstraints!
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 16
        
        anchoredContstraints = bubbleContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        anchoredContstraints.leading?.constant = 20
        anchoredContstraints.trailing?.constant = -20
        
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 285).isActive = true
        
        bubbleContainer.addSubview(textView)
        textView.fillSuperview(padding: .init(top: 4, left: 12, bottom: 4, right: 12))
    }
}
