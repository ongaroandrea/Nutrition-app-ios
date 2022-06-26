//
//  VisitIntro.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 21/05/22.
//

import SwiftUI

struct VisitIntro: View {
    
    var id: String
    @State private var viewModel: MisurationVM = MisurationVM()
    var follow_up : LocalizedStringKey = "follow_up_testo"
    var dieta : LocalizedStringKey = "dieta_testo"
    var idratazione : LocalizedStringKey = "idratazione_testo"
    var bia : LocalizedStringKey = "follow_up_testo"
    var follow_up_titolo : LocalizedStringKey = "follow_up_titolo"
    var dieta_titolo : LocalizedStringKey = "dieta_titolo"
    var idratazione_titolo : LocalizedStringKey = "idratazione_titolo"
    var bia_titolo : LocalizedStringKey = "follow_up_titolo"
    var riepilogo_visita : LocalizedStringKey = "riepilogo_visita"

    var body: some View {
            VStack{
                Text(riepilogo_visita.stringValue())
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                
                NavigationLink(destination: ChartsView(id: id)){
                    CardVisitView(title: follow_up_titolo.stringValue(), subtitle: follow_up.stringValue())
                }
                
                NavigationLink(destination: ListDiets(id: id)){
                    CardVisitView(title: dieta_titolo.stringValue(), subtitle: dieta.stringValue())
                }
                
                NavigationLink(destination: BMIRadarChartView(entries: viewModel.loadRadar(idVisit: id))){
                    CardVisitView(title: bia_titolo.stringValue(), subtitle: bia.stringValue())
                }
                
                NavigationLink(destination: WaterAnimation(id: id)){
                    CardVisitView(title: idratazione_titolo.stringValue(), subtitle: idratazione.stringValue())
                }
                
                Spacer()
            }.onAppear(perform: {
                
                print(viewModel.radarData)
            })
        
    }
}

struct VisitIntro_Previews: PreviewProvider {
    static var previews: some View {
        VisitIntro(id: "1")
    }
}

struct CardVisitView: View {
    
    var title: String
    var subtitle: String
    var body: some View {
        VStack {
                HStack {
                    VStack(alignment: .leading) {
                       
                        Text(title)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color("Primary"))
                            .lineLimit(3)
                        Text(subtitle.uppercased())
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                        
                    }
                    .layoutPriority(100)
     
                    Spacer()
                }
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .padding([.top, .horizontal])
        }

}
