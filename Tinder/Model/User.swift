//
//  User.swift
//  Tinder
//
//  Created by Cory Kim on 14/01/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    // defining our properties for our model layer
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .bold)]))
        
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
}
