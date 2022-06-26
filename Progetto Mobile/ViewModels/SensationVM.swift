//
//  SensationVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 03/06/22.
//

import Foundation
import GRDB

class SensationVM: DataWrapper, ObservableObject {
    
    @Published var listSensation: [Sensation] = []
    @Published var sensation: Sensation? = nil

    func getSensationByID(idSensation: String){
        print("ID test")
        print(idSensation)
        do {
            try getDatabase().write { db in
                sensation = try Sensation
                    .filter(Column("id") == idSensation)
                    .fetchOne(db)
            }
        } catch{
            print(error)
            
        }
    }
    
    func createSensation(description: String) -> Bool {
        do {
            try getDatabase().write { db in
                let currentDateTime = Date()
                let id = KeychainStorage.getCredentials()!.id
                
                try Sensation(date: currentDateTime, description: description, userID: id).insert(db)
            }
            return true
        } catch {
            print(error)
            return false
        }
        
    }
    
    func loadAll(){
        
        do {
            try getDatabase().write { db in
                listSensation = try Sensation
                    .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadAllR() -> [Sensation] {
        
        do {
            try getDatabase().write { db in
                listSensation = try Sensation
                    .fetchAll(db)
            }
        } catch{
            return []
        }
        return listSensation
    }
}
