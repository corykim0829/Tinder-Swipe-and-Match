//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Cory Kim on 19/03/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class RegistrationViewModel {

    var bindableIsRegisterating = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        self.bindableIsRegisterating.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                completion(err)
                return
            }
            
            print("Successfully registered user : ", res?.user.uid ?? "")
            
            // Only upload images to Firebase Storage once you are authorized
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            ref.putData(imageData, metadata: nil, completion: { (_, err) in
                
                if let err = err {
                    completion(err)
                    return // bail
                }
                
                print("Finished uploading image to storage")
                ref.downloadURL(completion: { (url, err) in
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    self.bindableIsRegisterating.value = false
                    print("Download url of our image is :", url?.absoluteString ?? "")
                    // stroe the download url into Firestore next lesson
                })
            })
        }
    }
    
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
