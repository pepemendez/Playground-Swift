//
//  UserPreferences.swift
//  Test
//
//  Created by José Méndez on 7/28/20.
//  Copyright © 2020 José Méndez. All rights reserved.
//

import Foundation

class UserPreferences {
    public static var jwtToken: String{
        get{
            let preferences = UserDefaults.standard;
            if let token = preferences.string(forKey: "_JWTToken"){
                return token
            }
            else{
                return ""
            }
        }
        set{
            let preferences = UserDefaults.standard;
            preferences.set(newValue, forKey: "_JWTToken")
        }
    }
}

