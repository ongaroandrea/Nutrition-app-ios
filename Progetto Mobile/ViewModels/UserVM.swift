//
//  UserVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 10/05/22.
//

import Foundation
import GRDB
import SwiftKeychainWrapper

class UserVM: DataWrapper, ObservableObject {
    
    @Published var status: String = ""
    @Published var userLogged: User? = nil
    
    func loginUser(mail: String, password: String) -> Bool {
        var user: User?
        do {
            try getDatabase().write { db in
                user = try User.filter(Column("email") == mail).filter(Column("password") == password).fetchOne(db)
            }
        } catch{
            print(error)
            return false
        }
        if user != nil {
            print(KeychainStorage.saveCredentials(Credentials(id: user!.id, email: mail, password: password)))
            userLogged = user!
            return false
        } else {
            return true
        }
    }
    
    func createUser(name: String, surname: String, mail: String, password: String, confirmPassword: String) -> Bool {
        var error = true
        if(checkData(mail: mail, password: password, confirmPassword: confirmPassword)){
            do {
                try getDatabase().write { db in
                    try User(name: name, surname: surname, email: mail, password: password, dataNascita: "26/02/2012", sport: "").insert(db)
                }
                error = false
                status = "Inserito Correttamente"
                getAllUser()
                
            } catch{
                status = "error"
                print(error)
            }
        } else{
            status = "error"
        }
        return error
    }
    
    func checkData(mail: String, password: String, confirmPassword: String) -> Bool {
        return password == confirmPassword && isValidEmail(mail)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setCurrentUser() {
        if  KeychainStorage.getCredentials() != nil {
            do {
                _ = try getDatabase().read { db in
                    userLogged = try User.filter(id: KeychainStorage.getCredentials()!.id).fetchOne(db)
                }
            } catch{
                print(error)
            }
        }
        
    }
    
    func getAllUser() {
        do {
            let users: [User] = try getDatabase().read{ db in
                try User.fetchAll(db)
            }
            print(users)
        } catch{
            print(error)
        }
    }
    
    func logoutUser() -> Bool {
        KeychainStorage.removeCredentials()
    }
    
    func updateUser(name: String, surname: String, sport: String, password: String, email: String) -> Bool{
        if name == "" || surname == "" || password == "" || email == "" {
            return true
        }
        
        do {
            try getDatabase().write { db in
                if let user = try User.fetchOne(db, id: KeychainStorage.getCredentials()!.id) {
                    user.name = name;
                    user.sport = sport
                    user.surname = surname
                    user.password = password
                    user.email = email
                    try user.update(db)
                }
            }
            return false
        } catch {
            print(error)
            return true
        }
    }
    
}
