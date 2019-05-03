//
//  LoginViewModel.swift
//  Tinder
//
//  Created by Cory Kim on 03/05/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    var isFormValid = Bindable<Bool>()
    var isLoggingIn = Bindable<Bool>()
    
    var email: String? { didSet { checkValidity() } }
    var password: String? { didSet { checkValidity() } }
    
    fileprivate func checkValidity() {
        isFormValid.value = email?.isEmpty == false && password?.isEmpty == false
    }
    
    func performLogin(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        self.isLoggingIn.value = true
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            completion(err)
        }
    }
}
