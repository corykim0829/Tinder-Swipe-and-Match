//
//  Match.swift
//  Tinder
//
//  Created by Cory Kim on 2019/09/26.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import Foundation

struct Match {
    let name, profileImageUrl, uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
