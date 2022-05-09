//
//  Recipr.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Recipe: Identifiable{
    let id: Int64
    let time: Int64
    let difficulty: String
    let ingredients: [FoodUsed]
}

extension Recipe: Codable, FetchableRecord, PersistableRecord {}
