//
//  KeychainStorage.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 20/05/22.
//

import Foundation
import SwiftKeychainWrapper

enum KeychainStorage {
    static let key = "credentials"
    
    static func getCredentials() -> Credentials? {
        if let myCredentialsString = KeychainWrapper.standard.string(forKey: Self.key){
            return Credentials.decode(myCredentialsString)
        }
        return nil
    }
    
    static func saveCredentials(_ credentials: Credentials) -> Bool {
        if KeychainWrapper.standard.set(credentials.encoded(), forKey: Self.key) {
            return true
        }
        return false
    }
    
    static func removeCredentials() -> Bool {
        
        let key: KeychainWrapper.Key = "credentials"
        KeychainWrapper.standard.remove(forKey: key)
        return true
    }
}
