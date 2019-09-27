//
//  MatchMessagesController.swift
//  Tinder
//
//  Created by Cory Kim on 04/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools
import Firebase

class RecentMessageCell: LBTAListCell<UIColor> {
    
    let userImageView = UIImageView(image: #imageLiteral(resourceName: "kelly1"), contentMode: .scaleAspectFill)
    
    let usernameLabel = UILabel(text: "USERNAME", font: .systemFont(ofSize: 16, weight: .bold), textColor: .darkGray, numberOfLines: 1)
    
    let messageTextLabel = UILabel(text: "some texts from the most recent message from user", font: .systemFont(ofSize: 14), textColor: .gray, textAlignment: .left, numberOfLines: 2)
    
    
    override var item: UIColor! {
        didSet {
//            backgroundColor = item
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

class MatchesMessagesController: LBTAListHeaderController<RecentMessageCell, UIColor, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalController.matchesMessagesController = self
    }
    
    func didSelectMatchFromHeader(match: Match) {
        print("match:", match.name)
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 228)
    }
    
    let customNavBar = MatchesNavBar() 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [.red, .blue, .green, .yellow, .purple, .red, .blue, .green, .yellow, .purple]
        
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 120))
        
        collectionView.contentInset.top = 140
        collectionView.scrollIndicatorInsets.top = 140
        
        let statusBarCoverView = UIView(backgroundColor: .white)
        view.addSubview(statusBarCoverView)
        statusBarCoverView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        fetchRecentMessages()
    }
    
    fileprivate func fetchRecentMessages() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("matches_messages").document(currentUserId)
        
//        query
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 4, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
