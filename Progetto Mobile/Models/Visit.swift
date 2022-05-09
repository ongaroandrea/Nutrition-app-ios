//
//  Visit.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Visit: Identifiable{
    let id: Int64
    let date: String
    let userID: Int64
}

//To work with GRDB
extension Visit: Codable, FetchableRecord, PersistableRecord {}
