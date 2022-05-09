//
//  Diets.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Diets: Identifiable{
    let id: Int64
}

extension Diets: Codable, FetchableRecord, PersistableRecord {}
