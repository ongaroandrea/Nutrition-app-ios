//
//  Visit.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Visit: Identifiable{
    let id: String
    let date: Date
    let userID: String
    
    init(id: String, date: Date, userID: String){
        self.id = id
        self.date = date
        self.userID = userID
    }
    
    init(date: Date, userID: String){
        self.id = UUID().uuidString
        self.date = date
        self.userID = userID
    }
}

//To work with GRDB
extension Visit: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "visit"
}




