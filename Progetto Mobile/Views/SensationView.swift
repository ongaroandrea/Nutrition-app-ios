//
//  Sensation.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 25/06/22.
//

import SwiftUI

struct SensationView: View {
    
    var id: String
    @StateObject var viewModel: SensationVM = SensationVM()
    var body: some View {
        ZStack(alignment: .top){
            VStack(alignment: .leading, spacing: 30){
                Text("Dati sensazioni")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("AccentColor"))
                
                
                VStack(alignment: .leading){
                    Text("Data")
                        .font(.body)
                        .bold()
                        .foregroundColor(Color("AccentColor"))
                    Text(viewModel.sensation?.date.formatted() ?? Date().formatted())
                }
                
                VStack(alignment: .leading){
                    Text("Descrizione")
                        .font(.body)
                        .bold()
                        .foregroundColor(Color("AccentColor"))
                    Text(viewModel.sensation?.description ?? "")
                    
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.top, -30)
        }
        .onAppear(perform: {
            viewModel.getSensationByID(idSensation: id)
        })
    }
}

struct SensationView_Previews: PreviewProvider {
    static var previews: some View {
        SensationView(id: "1")
    }
}
