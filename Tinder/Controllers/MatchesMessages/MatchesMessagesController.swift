//
//  MatchMessagesController.swift
//  Tinder
//
//  Created by Cory Kim on 04/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools
import Firebase

class NewMatchesHorizontalController: LBTAListController<MatchCell, Match>, UICollectionViewDelegateFlowLayout {
    
    var matchesMessagesController: MatchesMessagesController?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = items[indexPath.item]
        matchesMessagesController?.didSelectMatchFromHeader(match: match)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 110, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 4, bottom: 0, right: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        fetchMatches()
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").order(by: "timestamp", descending: true)
        
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Failed to fetch matches_messages:", err)
                return
            }
            
            print("fetch all matches messages users")
            
            var matches = [Match]()
            querySnapshot?.documents.forEach({ (documentSnapshot) in
                let dictionary = documentSnapshot.data()
                matches.append(.init(dictionary: dictionary))
            })
            
            self.items = matches
            self.collectionView.reloadData()
        }
    }
}

class MatchesHeader: UICollectionReusableView {
    
    let newMatchedLabel = UILabel(text: "New Matches", font: .systemFont(ofSize: 18, weight: .bold), textColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    
    let matchesHorizontalController = NewMatchesHorizontalController()
    
    let messagesLabel = UILabel(text: "Messages", font: .systemFont(ofSize: 18, weight: .bold), textColor: #colorLiteral(red: 1, green: 0.423529923, blue: 0.4469795823, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(stack(newMatchedLabel).padLeft(20),
              matchesHorizontalController.view,
              stack(messagesLabel).padLeft(20),
              spacing: 20).withMargins(.init(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MatchesMessagesController: LBTAListHeaderController<MatchCell, Match, MatchesHeader>, UICollectionViewDelegateFlowLayout {
    
    override func setupHeader(_ header: MatchesHeader) {
        header.matchesHorizontalController.matchesMessagesController = self
    }
    
    fileprivate func didSelectMatchFromHeader(match: Match) {
        print("match:", match.name)
        let chatLogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    let customNavBar = MatchesNavBar() 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 110, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let match = items[indexPath.item]
        let chatlogController = ChatLogController(match: match)
        navigationController?.pushViewController(chatlogController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMatches()
        
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
    }
    
    fileprivate func fetchMatches() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("matches_messages").document(currentUserId).collection("matches").order(by: "timestamp", descending: true)
        
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Failed to fetch matches_messages:", err)
                return
            }
            
            print("fetch all matches messages users")
            
            var matches = [Match]()
            querySnapshot?.documents.forEach({ (documentSnapshot) in
                let dictionary = documentSnapshot.data()
                matches.append(.init(dictionary: dictionary))
            })
            
            self.items = matches
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
