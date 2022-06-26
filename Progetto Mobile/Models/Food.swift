//
//  Food.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Food: Identifiable{
    let id: Int64
    let name: String
    let calories: Double
}


extension Food: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "food"
}

extension Food: TableRecord {
    static let foods = hasMany(Food.self)
}
