//
//  DietsVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 17/05/22.
//

import Foundation
import GRDB

class DietsVM: DataWrapper, ObservableObject {
    
    @Published var colazione: [FoodUsedInfo] = []
    @Published var merenda1: [FoodUsedInfo] = []
    @Published var pranzo: [FoodUsedInfo] = []
    @Published var merenda2: [FoodUsedInfo] = []
    @Published var cena: [FoodUsedInfo] = []
    @Published var lastIDVisit = ""
    func getIDLastVisit() -> String {
        var visit: Visit?
        if KeychainStorage.getCredentials() != nil {
            let id = KeychainStorage.getCredentials()!.id
            do {
                try  getDatabase().write { db in
                    visit = try Visit
                                    .order(Column("date").desc)
                                    .filter(Column("userID") == id)
                                    .fetchOne(db)
                }
            } catch{
                print(error)
            }
        }
        
        
        if visit != nil {
            lastIDVisit = visit!.id
        } else {
            lastIDVisit = "0"
        }
        
        return lastIDVisit
    }
    
    
    func loadColazione(visitID: String, language: String, id: Int64 ){
        if(visitID == ""){
            colazione = []
            return
        }
        do {
            try  getDatabase().write { db in
                colazione = try FoodUsed
                                .filter(Column("visit_state") == "Colazione")
                                .filter(Column("day") == id)
                                .filter(Column("dietsID") == visitID)
                                .including(required: FoodUsed.fooding)
                                .asRequest(of: FoodUsedInfo.self)
                                .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadMerenda1(visitID: String, language: String, id: Int64 ){
        if(visitID == ""){
            merenda1 = []
            return
        }
        do {
            try  getDatabase().write { db in
                merenda1 = try FoodUsed
                                .filter(Column("visit_state") == "Merenda1")
                                .filter(Column("day") == id)
                                .filter(Column("dietsID") == visitID)
                                .including(required: FoodUsed.fooding)
                                .asRequest(of: FoodUsedInfo.self)
                                .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadPranzo(visitID: String, language: String, id: Int64 ){
        if(visitID == ""){
            pranzo = []
            return
        }
        do {
            try  getDatabase().write { db in
                pranzo = try FoodUsed
                                .filter(Column("visit_state") == "Pranzo")
                                .filter(Column("day") == id)
                                .filter(Column("dietsID") == visitID)
                                .including(required: FoodUsed.fooding)
                                .asRequest(of: FoodUsedInfo.self)
                                .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadMerenda2(visitID: String, language: String, id: Int64 ){
        if(visitID == ""){
            merenda2 = []
            return
        }
        do {
            try  getDatabase().write { db in
                merenda2 = try FoodUsed
                                .filter(Column("visit_state") == "Merenda2")
                                .filter(Column("day") == id)
                                .filter(Column("dietsID") == visitID)
                                .including(required: FoodUsed.fooding)
                                .asRequest(of: FoodUsedInfo.self)
                                .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    func loadCena(visitID: String, language: String, id: Int64 ){
        if(visitID == ""){
            cena = []
            return
        }
        do {
            try  getDatabase().write { db in
                cena = try FoodUsed
                                .filter(Column("visit_state") == "Cena")
                                .filter(Column("day") == id)
                                .filter(Column("dietsID") == visitID)
                                .including(required: FoodUsed.fooding)
                                .asRequest(of: FoodUsedInfo.self)
                                .fetchAll(db)
            }
        } catch{
            print(error)
        }
    }
    
    /*
    func getAllFoods(){
        do {
            try  getDatabase().write { db in
                let test = try FoodUsed.fetchAll(db)
                
            }
        } catch{
            print(error)
        }
    }
     */
}
