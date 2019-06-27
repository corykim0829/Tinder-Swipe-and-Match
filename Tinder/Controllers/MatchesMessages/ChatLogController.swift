//
//  ChatLogController.swift
//  Tinder
//
//  Created by Cory Kim on 12/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class ChatLogController: LBTAListController<MessageCell, Message>, UICollectionViewDelegateFlowLayout {
    
    fileprivate lazy var customNavBar = ChatLogNavBar(match: match)
    fileprivate let navBarHeight: CGFloat = 120
    
    fileprivate var match: Match
    
    init(match: Match) {
        self.match = match
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.keyboardDismissMode = .interactive
        
        items = [
            .init(text: "For this lesson, let's talk all about auto sizing message cells and how to shift alignment from left to right.  Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isFromCurrentLoggedUser: false),
            .init(text: "Hello I'm 태평양 거북이", isFromCurrentLoggedUser: false),
            .init(text: "Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isFromCurrentLoggedUser: true),
            .init(text: "I'm a turtle", isFromCurrentLoggedUser: false),
            .init(text: "For this lesson, let's talk all about auto sizing message cells and how to shift alignment from left to right.  Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isFromCurrentLoggedUser: true),
            .init(text: "And I'm a really cute turtle", isFromCurrentLoggedUser: false)
            
        ]
        
        setupUI()
    }
    
    // input accessory view
    
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
    
    lazy var redView: UIView = {
        
        let customInputAccessoryView = CustomInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        // limit input view height
        customInputAccessoryView.heightAnchor.constraint(lessThanOrEqualToConstant: 110).isActive = true
        
        return customInputAccessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return redView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        collectionView.scrollIndicatorInsets.top = navBarHeight
        
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        
        collectionView.contentInset.top = navBarHeight
        
        let statusBarCover = UIView(backgroundColor: .white)
        view.addSubview(statusBarCover)
        statusBarCover.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // estimated sizing
        let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        estimatedSizeCell.item = self.items[indexPath.item]
        
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
