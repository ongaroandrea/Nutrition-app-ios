//
//  Charts.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @StateObject var viewModel: MisurationVM = MisurationVM()
    var id: String
    var body: some View {
        VStack{
            Text("FOLLOW UP")
                .font(.title)
                .bold()
                .foregroundColor(Color("AccentColor"))
            
            TabView{
                ChartsTab(text: "BYCEPS", data: viewModel.measureByceps, espresso: "espresso in cm")
                ChartsTab(text: "BMI", data: viewModel.measureBMI, espresso: "espresso in cm")
                ChartsTab(text: "FIANCHI", data: viewModel.measureHip, espresso: "espresso in cm")
                ChartsTab(text: "CORE", data: viewModel.measureCore, espresso: "espresso in cm")
                ChartsTab(text: "Quad", data: viewModel.measureQuad, espresso: "espresso in cm")
                ChartsTab(text: "Pliche", data: viewModel.measurePliche, espresso: "espresso in cm")
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            
        }
        .onAppear( perform: {
            viewModel.loadMisurations(id: id)
        })
    }
}

struct Charts_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView(id: "1")
    }
}
