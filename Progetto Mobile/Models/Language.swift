//
//  Languages.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 10/05/22.
//

import Foundation

import GRDB

struct Language: Identifiable {
    let id: Int64
    let name: String
}

extension Language: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "language"
}
