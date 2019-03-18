//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Cory Kim on 19/03/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObsever?(isFormValid)
    }
    
    // Reactive programming
    var isFormValidObsever: ((Bool) -> ())?
}
