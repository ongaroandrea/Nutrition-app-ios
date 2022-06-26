//
//  Diets.swift
//  test
//
//  Created by Andrea  Ongaro on 01/04/22.
//

import SwiftUI

struct DietsView: View {
    
    @ObservedObject var viewModel: DietsVM
    var id: Int64
    var idVisit: String
    var body: some View {
        
        VStack{
            Text("Dieta Giorno \(id)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))
            List{
               
                Section(header: Text("Colazione")){
                    ForEach(viewModel.colazione) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                
                .headerProminence(.increased)
                
                Section(header: Text("PRIMA MERENDA")){
                    ForEach(viewModel.merenda1) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text("PRANZO")){
                    ForEach(viewModel.pranzo) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text("SECONDA MERENDA")){
                    ForEach(viewModel.merenda2) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text("CENA")){
                    ForEach(viewModel.cena) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                }
                .headerProminence(.increased)
            }
            .listStyle(.sidebar)
            .onAppear(perform: {
                let language = self.viewModel.getSystemLanguage()
                self.viewModel.loadColazione(visitID: idVisit, language: language, id: id)
                self.viewModel.loadMerenda1(visitID: idVisit, language: language, id: id)
                self.viewModel.loadPranzo(visitID: idVisit, language: language, id: id)
                self.viewModel.loadMerenda2(visitID: idVisit, language: language, id: id)
                self.viewModel.loadCena(visitID: idVisit, language: language, id: id)
                UITableView.appearance().backgroundColor = .clear
            })
            .onDisappear(perform: {
                UITableView.appearance().backgroundColor = UIColor.systemBackground
            })
        }
    }
}

struct Diets_Previews: PreviewProvider {
    static var previews: some View {
        DietsView(viewModel: DietsVM(), id: 1, idVisit: "1")
    }
}
