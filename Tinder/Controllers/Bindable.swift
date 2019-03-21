//
//  Bindable.swift
//  Tinder
//
//  Created by Cory Kim on 21/03/2019.
//  Copyright © 2019 CoryKim. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
