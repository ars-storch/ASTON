//
//  LoginViewModel.swift
//  RickAndMorty
//
//  Created by Арсений Сторчевой on 14.10.2022.
//

import Foundation
import UIKit

class LoginViewModel {
    
    var isLoggedIn: Bool = false
    
    var statusText = Dynamic(value: "")
    var statusColor = Dynamic(value: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    
    func loginButtonPressed(login: String?, password: String?) {
        let standardUD = UserDefaults.standard
        
        let loginStatus = standardUD.bool(forKey: UserDefaultKeys.isLoggedIn.rawValue) 
        
        guard login?.count ?? 0 > 4, password?.count ?? 0 > 4 else {
            statusText.value = "Login & password \n should be longer \n than 4-letters..."
            statusColor.value = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            print("Login & password \n should be longer \n than 4-letters...")
            return
        }
        
        if loginStatus == false {
            standardUD.set(true, forKey: UserDefaultKeys.isLoggedIn.rawValue)
            standardUD.synchronize()
            isLoggedIn = true
        } else if loginStatus == true {
            isLoggedIn = true
        }
        
    }
}

