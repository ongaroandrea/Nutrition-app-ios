//
//  Notification.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 10/04/22.
//

import Foundation
import GRDB

struct Notification: Identifiable {
    let id: Int64
    let weekDay: Int64
    let hours: Int64
    let minutes: Int64
    let userID: Int64
}

extension Notification: Codable, FetchableRecord, PersistableRecord {}
