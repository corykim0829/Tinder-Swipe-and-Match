//
//  RecentMessage.swift
//  Tinder
//
//  Created by Cory Kim on 2019/10/15.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import Firebase

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
