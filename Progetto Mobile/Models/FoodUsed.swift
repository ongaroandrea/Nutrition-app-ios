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
    let visit_state: String
    let day: Int
    let dietsID: Int64
    
    init(id: Int64, foodID: Int64, quantity: Double, visit_state: String, day: Int, dietsID: Int64){
        self.id = id
        self.foodID = foodID
        self.quantity = quantity
        self.visit_state = visit_state
        self.day = day
        self.dietsID = dietsID
    }
}

extension FoodUsed: TableRecord{
    static let fooding = belongsTo(Food.self)
}

extension FoodUsed: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "foodUsed"
}

struct FoodUsedInfo: TableRecord, Identifiable, FetchableRecord, Decodable {
    let id: Int64
    let foodID: Int64
    let quantity: Double
    let visit_state: String
    let day: Int
    let dietsID: Int64
    let food: Food
    
    init(id: Int64, foodID: Int64, quantity: Double, visit_state: String, day: Int, dietsID: Int64, food: Food){
        self.id = id
        self.foodID = foodID
        self.quantity = quantity
        self.visit_state = visit_state
        self.day = day
        self.dietsID = dietsID
        self.food = food
    }
}
