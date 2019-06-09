//
//  MatchMessagesController.swift
//  Tinder
//
//  Created by Cory Kim on 04/06/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import LBTATools

class MatchesMessagesController: UICollectionViewController {
    
    let customNavBar = MatchesNavBar() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        customNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}
