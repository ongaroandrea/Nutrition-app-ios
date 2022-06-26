//
//  Sensation.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 03/06/22.
//

import Foundation
import GRDB

final class Sensation: Identifiable {
    let id: String
    let date: Date
    var description: String
    let userID: String
    
    init(date: Date, description: String, userID: String){
        self.id = UUID().uuidString
        self.date = date
        self.description = description
        self.userID = userID
    }
    
    init(id: String, date: Date, description: String, userID: String){
        self.id = id
        self.date = date
        self.description = description
        self.userID = userID
    }
}

extension Sensation: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "sensation"
}
