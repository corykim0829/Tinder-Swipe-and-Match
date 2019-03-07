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

// ViewModel is supposed to represent the State of our View
class CardViewModel {
    // we'll define the properties that are view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    // Reactive Programming
    var imageIndexObserver: ((Int, UIImage?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(imageIndex - 1, 0)
    }
}
// what exactly do we do with this card view model thing??
