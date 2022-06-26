//
//  Recipr.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Recipe: Identifiable {
    let id: Int64
    let title: String
    let time: String
    let image: String
    let difficulty: Int
    let description: String
    
    init(id: Int64, title: String, time: String, image: String, difficulty: Int, description: String){
        self.id = id
        self.title =  title
        self.time = time
        self.image = image
        self.difficulty = difficulty
        self.description = description
    }
}

extension Recipe: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "recipe"
}
