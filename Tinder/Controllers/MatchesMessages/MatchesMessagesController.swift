//
//  MatchMessagesController.swift
//  Tinder
//
//  Created by Cory Kim on 04/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools
import Firebase
import FirebaseAuth
import FirebaseFirestore

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

struct RecentMessage {
    let uid, name, profileImageUrl, text: String
    let timestamp: Timestamp
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}

class MatchesMessagesController: LBTAListHeaderController<RecentMessageCell, RecentMessage, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    var recentMessagesDictionary = [String: RecentMessage]()
    
    fileprivate func fetchRecentMessages() {
            guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("matches_messages").document(currentUserId).collection("recent_messages").addSnapshotListener { (querySnapshot, err) in
            // check err
            
            querySnapshot?.documentChanges.forEach({ (change) in
                if change.type == .added || change.type == .modified {
                    let dictionary = change.document.data()
                    let recentMessage = RecentMessage(dictionary: dictionary)
                    self.recentMessagesDictionary[recentMessage.uid] = recentMessage
                }
            })
            
            self.resetItems()
        }
    }
    
    fileprivate func resetItems() {
        let values = Array(recentMessagesDictionary.values)
        items = values.sorted(by: { (rm1, rm2) -> Bool in
            return rm1.timestamp.compare(rm2.timestamp) == .orderedDescending
        })
        collectionView.reloadData()
    }
    
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
        
        fetchRecentMessages()
        
        items = [
//            .init(uid: "7uATkYNejZU3A7p2t8OpYnpuBu22", name: "noname", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/tinderswipematchfirestor-afc99.appspot.com/o/images%2F55CA3D91-ACA5-464B-96EC-3A1E6A94EED3?alt=media&token=d47cb96b-b10c-4e65-af67-20ea8a1941c0", text: "코리는 코리다", timestamp: Timestamp(date: .init()))
        ]
        
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 120))
        
        collectionView.contentInset.top = 140
        collectionView.scrollIndicatorInsets.top = 140
        
        let statusBarCoverView = UIView(backgroundColor: .white)
        view.addSubview(statusBarCoverView)
        statusBarCoverView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 4, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
