//
//  MisurationTaken.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct MisurationTaken: Identifiable {
    let id: Int64
    let misurationID: Int64
    let quantity: Int64
    let userID: Int64
}

extension MisurationTaken: Codable, FetchableRecord, PersistableRecord {}
