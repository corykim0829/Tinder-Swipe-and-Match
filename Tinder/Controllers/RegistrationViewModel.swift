//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Cory Kim on 19/03/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit

class RegistrationViewModel {

    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
//        isFormValidObsever?(isFormValid)
    }
    
    //    var image: UIImage? {
    //        didSet {
    //            imageObserver?(image)
    //        }
    //    }
    //
    //    var imageObserver: ((UIImage?) -> ())?
    
    // Reactive programming
//    var isFormValidObsever: ((Bool) -> ())?
}
