//
//  User.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 06/04/22.
//

import Foundation
import GRDB

struct User: Identifiable {
    let id: Int64
    var name: String
    let surname: String
    let email: String
    let password: String
    let dataNascita: String
    let subscriptionID: Int64
    
    init(id: Int64, name: String, surname: String, email: String, password: String, dataNascita: String, subscriptionID: Int64){
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.dataNascita = dataNascita
        self.subscriptionID = subscriptionID
    }
}

//To work with GRDB
extension User: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "user"
}

extension User: TableRecord{
    static let subscription = belongsTo(Subscription.self)
}

struct UserInfo: Identifiable, FetchableRecord, Decodable {
    let id: Int64
    let name: String
    let surname: String
    let email: String
    let password: String
    let dataNascita: String
    let subscriptionID: Int64
    let subscription: Subscription
    
    init(id: Int64, name: String, surname: String, email: String, password: String, dataNascita: String, subscriptionID: Int64, sub :Subscription){
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.dataNascita = dataNascita
        self.subscriptionID = subscriptionID
        self.subscription = sub
    }
}


