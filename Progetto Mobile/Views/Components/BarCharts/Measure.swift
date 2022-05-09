//
//  Measure.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import Foundation
import Charts

struct Measure {
    var type: String
    var data: String
    var value: Double
    var order: Double
    
    static func dataEntriesFroType(_ type: String, measure:[Measure]) -> [BarChartDataEntry] {
        let typeMeasure = measure.filter{$0.type == type}
        print(typeMeasure)
        return typeMeasure.map{BarChartDataEntry(x: $0.order, y: $0.value)}
    }
    
    static func getXProperty(measure:[Measure]) -> [String] {
        let typeMeasure = measure.filter{$0.type == "Byceps"}
        return typeMeasure.map{$0.data}
    }
    
    static func getXPropertyRadar() -> [String] {
        return ["FFM", "BMI", "TBW", "BCM", "TM"]
    }
    
    static func dataEntriesRadar() -> [RadarChartDataEntry] {
        return [
            RadarChartDataEntry(value: 6.6, data: "FFM"),
            RadarChartDataEntry(value: 1.8, data: "BMI"),
            RadarChartDataEntry(value: 5.8, data: "TBW"),
            RadarChartDataEntry(value: 6.8, data: "BCM"),
            RadarChartDataEntry(value: -3.6, data: "FM")
        ]
    }
    
    static func massDataPie() -> [PieChartDataEntry] {
        return [
            PieChartDataEntry(value: 91, label: "% Massa Magra"),
            PieChartDataEntry(value: 9, label: "% Massa Grassa"),
        ]
    }
    static var allMeasure:[Measure]{
        [
            Measure(type: "Byceps", data: "2021-01-01", value: 30.6, order: 0),
            Measure(type: "Byceps", data: "2021-03-01", value: 35, order: 1),
            Measure(type: "Byceps", data: "2021-05-01", value: 40, order: 2),
            Measure(type: "Triceps", data: "2021-06-01", value: 10, order: 3),
            Measure(type: "Byceps", data: "2021-08-01", value: 45, order: 4),
            Measure(type: "Byceps", data: "2022-08-01", value: 12, order: 5),
            Measure(type: "Legs", data: "2022-02-01", value: 13, order: 6),
            Measure(type: "Byceps", data: "2022-07-01", value: 50, order: 7),
            Measure(type: "Byceps", data: "2022-05-01", value: 44, order: 8),
            
        ]
    }
}
