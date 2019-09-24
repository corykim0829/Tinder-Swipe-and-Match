//
//  CustomInputAccessoryView.swift
//  Tinder
//
//  Created by Cory Kim on 24/09/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class CustomInputAccessoryView: UIView {
    
    let textView = UITextView()
    
    let sendButton = UIButton(title: "SEND", titleColor: .black, font: .boldSystemFont(ofSize: 14), target: nil, action: nil)
    
    let placeholderLabel = UILabel(text: "Enter Message", font: .systemFont(ofSize: 18), textColor: .lightGray)
    
    // ??
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupShadow(opacity: 0.1, radius: 8, offset: .init(width: 0, height: -8), color: .lightGray)
        autoresizingMask = .flexibleHeight
        
        textView.font = .systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        
        sendButton.constrainHeight(60)
        sendButton.constrainWidth(60)
        
        let stackView = UIStackView(arrangedSubviews: [textView, sendButton])
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.withMargins(.init(top: 2, left: 16, bottom: 2, right: 16))
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: sendButton.leadingAnchor, padding: .init(top: 0, left: 22, bottom: 0, right: 0))
        placeholderLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
        
        //        hstack(textView,
        //               sendButton.withSize(.init(width: 60, height: 60)),
        //               alignment: .center
        //               ).withMargins(.init(top: 0, left: 16, bottom: 0, right: 16))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc fileprivate func handleTextChange() {
        placeholderLabel.isHidden = textView.text.count != 0
        
        // How to scrollEnable
        
        //            let numberOfLines = (textView.contentSize.height / (textView.font?.lineHeight)!)
        //            if numberOfLines >= 4 {
        //                textView.isScrollEnabled = true
        //                textView.contentSize.height = 96
        //                print("number of lines:", numberOfLines)
        //            } else {
        //                textView.isScrollEnabled = false
        //            }
    }
    
    deinit {
        // because of retain cycle
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
