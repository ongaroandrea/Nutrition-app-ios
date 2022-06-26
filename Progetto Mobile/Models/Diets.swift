//
//  Diets.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Diet: Identifiable{
    let id: Int64
    let visitID: Int64
    
    init(id: Int64, visitID: Int64){
        self.id = id
        self.visitID = visitID
    }
}

extension Diet: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "diets"
}

