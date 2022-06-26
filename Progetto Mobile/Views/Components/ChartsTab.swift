//
//  ChartsTab.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 03/06/22.
//

import SwiftUI
import Charts

struct ChartsTab: View {
    var text: String
    var data: [Measure]
    var espresso: String

    var body: some View {
        VStack {
            if data.isEmpty {
                VStack {
                    Spacer()
                    Text("Valori non registrati  o non ancora caricati")
                    Spacer()
                }
            } else {
                MeasureBarChartView(entries: Measure.dataEntriesFroType(measure: data), measure: data)
            }
            HStack(spacing: 20) {
                VStack {
                    Text(text)
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color("TextColor"))

                    Text(espresso)
                        .foregroundColor(Color("TextColor"))
                        .opacity(0.45)
                }

            }
        }
        .frame(height: 400)

    }
}

struct ChartsTab_Previews: PreviewProvider {
    static var previews: some View {
        ChartsTab(text: "Byceps", data: [
            Measure(type: "Byceps", data: "", value: 45, order: 0.0),
            Measure(type: "Byceps", data: "", value: 35, order: 1.0),
            Measure(type: "Byceps", data: "", value: 37.4, order: 2.0),
            Measure(type: "Byceps", data: "", value: 37, order: 3.0),
        ], espresso: "espresso in cm")
    }
}
