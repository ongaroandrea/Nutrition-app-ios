//
//  MisurationVM.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 16/05/22.
//

import Foundation
import GRDB
import SwiftUI
import Charts

class MisurationVM: DataWrapper, ObservableObject {
    
    @Published var status: String = ""
    @Published var measureWeight: [Measure] = []
    @Published var measureByceps: [Measure] = []
    @Published var measureCore: [Measure] = []
    @Published var measureBMI: [Measure] = []
    @Published var measureHip: [Measure] = []
    @Published var measureQuad: [Measure] = []
    @Published var measurePliche: [Measure] = []
    @Published var idra: Double = 0.0
    
    @Published var radarData: [RadarChartDataEntry] = []
    
    func loadMisurations(id: String){
        measureWeight = getMisurations(type: "Weight", idVisit: id)
        measureByceps = getMisurations(type: "Byceps", idVisit: id)
        measureCore = getMisurations(type: "Core", idVisit: id)
        measureBMI = getMisurations(type: "BMI", idVisit: id)
        measureHip = getMisurations(type: "Hip", idVisit: id)
        measureQuad = getMisurations(type: "Quad", idVisit: id)
        measurePliche = getMisurations(type: "Pliche", idVisit: id)
    }
    
    func getMisurations(type: String, idVisit: String) -> [Measure] {
        var misurations: [MisurationTakenInfo] = []
        var measureList: [Measure] = []
        let idss = getAllIds(date: getData(idVisit: idVisit)!)
        do {
            try getDatabase().write { db in
                misurations = try MisurationTaken
                                    .filter(Column("type") == type)
                                    .filter(idss.contains(Column("visitID")))
                                    .including(required: MisurationTaken.misuration.order(Column("date")))
                                    .asRequest(of: MisurationTakenInfo.self)
                                    .fetchAll(db)
                print(misurations)
            }
        } catch{
            print(error)
        }
        if !misurations.isEmpty {
            var i = 0
            for mis in misurations {
                measureList.append(Measure(type: mis.type, data: mis.visit.date.formatted(.dateTime.day().month().year()), value: mis.value, order: Double(i)))
                i += 1
            }
        }
        return measureList
    }
    
    func getData(idVisit: String) -> Date? {
        var visit: Visit?
        do {
            try getDatabase().write{ db in
                visit = try Visit.filter(id: idVisit).fetchOne(db)
            }
        } catch{
            print(error)
        }
        if visit != nil {
            print(visit!.date)
            return visit!.date
        }
        return nil
    }
    
    func getAllIds(date: Date) -> [String]{
        var ids: [String] = []
        do {
            try getDatabase().write{ db in
                ids = try Visit.filter(Column("date") <= date).selectID().fetchAll(db)
            }
        } catch{
            print(error)
        }
        return ids
    }
    
    func getAll(){
        do {
            try getDatabase().write{ db in
                let misu = try MisurationTaken.fetchAll(db)
                print(misu)
            }
        } catch{
            print(error)
        }
    }
    
    func loadHydra(idVisit: String) {
        var idrat : MisurationTaken? = nil
        idra = 0.0
        do {
            try getDatabase().write { db in
                idrat = try MisurationTaken
                                    .filter(Column("visitID") == idVisit)
                                    .fetchOne(db)
            }
        } catch{
            print(error)
        }
        if idrat != nil {
            idra = idrat!.value
        }
       
    }
    
    func loadRadar(idVisit: String) -> [RadarChartDataEntry] {
        let names : [String] = ["FFM", "BMI", "TBW", "BCM", "TM"]
        var date: [MisurationTaken] = []
        do {
            try getDatabase().write { db in
                date = try MisurationTaken
                                    .filter(Column("visitID") == idVisit)
                                    .filter(names.contains(Column("type")))
                                    .fetchAll(db)
            }
        } catch{
            print(error)
        }
        
        print(date)
        if !date.isEmpty {
            for mis in date {
                radarData.append(RadarChartDataEntry(value: mis.value))
            }
        }
        print(radarData)
        return radarData

    }
}
