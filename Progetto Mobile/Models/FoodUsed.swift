//
//  FoodUsed.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct FoodUsed: Identifiable{
    let id: Int64
    let foodID: Int64
    let quantity: Double
}

extension FoodUsed: Codable, FetchableRecord, PersistableRecord {}
