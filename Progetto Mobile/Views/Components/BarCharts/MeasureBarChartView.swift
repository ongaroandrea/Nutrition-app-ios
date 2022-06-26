//
//  MeasureBarChartView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import SwiftUI
import Charts

struct MeasureBarChartView: UIViewRepresentable{
    
    let entries: [BarChartDataEntry]
    let measure: [Measure]
    func makeUIView(context: Context) -> BarChartView {
        return BarChartView()
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = "Biceps" //ottenere il nome
        uiView.noDataText = "Nessun Dato Disponibile"
        uiView.data = BarChartData(dataSet: dataSet)
        uiView.rightAxis.enabled = false;
        uiView.leftAxis.enabled = true;
        uiView.leftAxis.drawAxisLineEnabled = false
        uiView.leftAxis.drawLabelsEnabled = false
        if(uiView.scaleX == 1.0){
            
            uiView.zoom(scaleX: 1.0, scaleY: 0.5, x: 0, y: 0)
        }
        
        uiView.setScaleEnabled(false)
        formatDataSet(dataSet: dataSet)
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
    }
    
    func formatDataSet(dataSet: BarChartDataSet){
        dataSet.colors = [.blue, .darkGray]
        dataSet.valueColors = [.black]
        dataSet.valueFont = UIFont.systemFont(ofSize: 12)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
    }
    
    func formatXAxis(xAxis: XAxis){
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Measure.getXProperty(measure: measure))
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularityEnabled = true
        xAxis.granularity = 1
        
        xAxis.labelCount = 5

        xAxis.labelPosition = .bottom
    }
    
    func formatLegend(legend: Legend){
        legend.enabled = false
        
    }
}

struct MeasureBarChartView_Previews: PreviewProvider{
    static var previews: some View {
        MeasureBarChartView(entries: Measure.dataEntriesFroType(measure: Measure.allMeasure), measure: Measure.allMeasure)
    }
}
