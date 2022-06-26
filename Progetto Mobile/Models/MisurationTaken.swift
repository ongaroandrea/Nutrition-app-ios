//
//  MisurationTaken.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct MisurationTaken: Identifiable {
    let id: String
    let type: String
    let value: Double
    let visitID: String
    
    init(id: String, type: String, value: Double, visitID: String){
        self.id = id
        self.type = type
        self.value = value
        self.visitID = visitID
    }
    
    init(type: String, value: Double, visitID: String){
        self.id = UUID().uuidString
        self.type = type
        self.value = value
        self.visitID = visitID
    }
}

extension MisurationTaken: TableRecord{
    static let misuration = belongsTo(Visit.self)
}
extension MisurationTaken: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "misurationTaken"
}

struct MisurationTakenInfo: TableRecord, Identifiable, FetchableRecord, Decodable {
    let id: String
    let type: String
    let value: Double
    let visitID: String
    let visit: Visit
    
    init(id: String, type: String, value: Double, visitID: String, visit : Visit){
        self.id = id
        self.type = type
        self.value = value
        self.visitID = visitID
        self.visit = visit
    }
}
