//
//  BMIRadarChartView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import Charts
import SwiftUI

struct BMIRadarChartView: UIViewRepresentable {
        
    let entries: [RadarChartDataEntry]
    
    func makeUIView(context: Context) -> RadarChartView {
        return RadarChartView()
    }
    
    func updateUIView(_ uiView: RadarChartView, context: Context) {
        let dataSet = RadarChartDataSet(entries: entries)
        dataSet.label = "Valori attuali" //ottenere il nome
        uiView.noDataText = "Nessun Dato Disponibile"
        uiView.data = RadarChartData(dataSet: dataSet)
        
        uiView.webColor = .black
        uiView.innerWebColor = .red
        formatDataSet(dataSet: dataSet)
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
        uiView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInElastic)
    }
    
    func formatXAxis(xAxis: XAxis){
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Measure.getXPropertyRadar())
        xAxis.labelWidth = 10
    }
    func formatDataSet(dataSet: RadarChartDataSet){
        dataSet.drawFilledEnabled = true
        dataSet.fillAlpha = 0.7
        dataSet.lineWidth = 2.0
        dataSet.drawHighlightCircleEnabled = true
        dataSet.setDrawHighlightIndicators(false)
        dataSet.colors = [.black]
        dataSet.valueColors = [.purple]
    }
    
    func formatLegend(legend: Legend){
    }
}

struct BMIRadarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BMIRadarChartView(entries: Measure.dataEntriesRadar())
            
    }
}

