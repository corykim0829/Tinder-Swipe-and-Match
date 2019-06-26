//
//  ChatLogController.swift
//  Tinder
//
//  Created by Cory Kim on 12/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

struct Message {
    let text: String
    let isFromCurrentLoggedUser: Bool
}

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
        
        items = [
            .init(text: "For this lesson, let's talk all about auto sizing message cells and how to shift alignment from left to right.  Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isMessageFromCurrentLoggedUser: false),
            .init(text: "Hello I'm 태평양 거북이", isMessageFromCurrentLoggedUser: false),
            .init(text: "Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isMessageFromCurrentLoggedUser: true),
            .init(text: "I'm a turtle", isMessageFromCurrentLoggedUser: false),
            .init(text: "For this lesson, let's talk all about auto sizing message cells and how to shift alignment from left to right.  Doing the alignment correctly within one cell makes it very easy to toggle things based on a chat message's properties later on.  We'll also look at some bug fixes at the end.", isMessageFromCurrentLoggedUser: true),
            .init(text: "And I'm a really cute turtle", isMessageFromCurrentLoggedUser: false)
            
        ]
        
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
