//
//  CardViewModel.swift
//  Tinder
//
//  Created by Cory Kim on 14/01/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    // we'll define the properties that are view will display/render out
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}

// what exactly do we do with this card view model thing??
