//
//  MassPieChartView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import Charts
import SwiftUI

struct MassPieChartView: UIViewRepresentable {
    
    let entries: [PieChartDataEntry]
    
    func makeUIView(context: Context) -> PieChartView {
        return PieChartView()
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.label = "Biceps" //ottenere il nome
        dataSet.colors = ChartColorTemplates.liberty().reversed()
        uiView.noDataText = "Nessun Dato Disponibile"
        uiView.data = PieChartData(dataSet: dataSet)
    }
      
}

struct MassPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        MassPieChartView(entries: Measure.massDataPie())
    }
}
