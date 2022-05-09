//
//  Subscription.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Subscription: Identifiable{
    let id: Int64
    let name: String
}

extension Subscription: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "subscription"
}

extension Subscription: TableRecord {
    static let users = hasMany(User.self)
}
