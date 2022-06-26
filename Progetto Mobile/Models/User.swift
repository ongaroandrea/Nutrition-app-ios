//
//  User.swift
//  SQLAPP
//
//  Created by Andrea  Ongaro on 06/04/22.
//

import Foundation
import GRDB

final class User: Identifiable {
    let id: String
    var name: String
    var surname: String
    var email: String
    var password: String
    var dataNascita: String
    var sport: String
    
    init(name: String, surname: String, email: String, password: String, dataNascita: String, sport: String){
        self.id = UUID().uuidString
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.dataNascita = dataNascita
        self.sport = sport
    }
    
    init(id: String, name: String, surname: String, email: String, password: String, dataNascita: String, sport: String){
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.dataNascita = dataNascita
        self.sport = sport
    }
    
}

//To work with GRDB
extension User: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "user"
}

struct Credentials: Codable {

    var id: String = ""
    var email: String = ""
    var password: String = ""
    
    func encoded() -> String {
        let encoder = JSONEncoder()
        let credentialsData = try! encoder.encode(self)
        return String(data: credentialsData, encoding: .utf8)!
    }
    
    static func decode(_ credentialString: String) -> Credentials {
        let decoder = JSONDecoder()
        let jsonData = credentialString.data(using: .utf8)
        return try! decoder.decode((Credentials.self), from: jsonData!)
    }
}

