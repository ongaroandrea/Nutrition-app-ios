//
//  Diets.swift
//  test
//
//  Created by Andrea  Ongaro on 01/04/22.
//

import SwiftUI

struct DietsView: View {
    
    var dieta_numero_titolo: LocalizedStringKey = "dieta_numero_titolo"
    var colazione: LocalizedStringKey = "colazione"
    var merenda1 : LocalizedStringKey = "merenda1"
    var pranzo: LocalizedStringKey = "pranzo"
    var merenda2: LocalizedStringKey = "merenda2"
    var cena: LocalizedStringKey = "cena"
    
    @ObservedObject var viewModel: DietsVM
    var id: Int64
    var idVisit: String
    var body: some View {
        
        VStack{
            Text(dieta_numero_titolo.stringValue() + " \(id)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Primary"))
                .padding(.top, -40)
            List{
               
                Section(header: Text(colazione.stringValue())){
                    ForEach(viewModel.colazione) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                
                .headerProminence(.increased)
                
                Section(header: Text(merenda1.stringValue())){
                    ForEach(viewModel.merenda1) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text(pranzo.stringValue())){
                    ForEach(viewModel.pranzo) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text(merenda2.stringValue())){
                    ForEach(viewModel.merenda2) { cibo in
                        HStack{
                            Text(String(cibo.food.name))
                            Spacer()
                            Text(String(cibo.quantity))
                        }
                    }
                    
                }
                .headerProminence(.increased)
                
                Section(header: Text(cena.stringValue())){
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
                print(language)
                print(idVisit)
                self.viewModel.loadColazione(visitID: idVisit, language: language, id: id)
                self.viewModel.loadMerenda1(visitID: idVisit, language: language, id: id)
                self.viewModel.loadPranzo(visitID: idVisit, language: language, id: id)
                self.viewModel.loadMerenda2(visitID: idVisit, language: language, id: id)
                self.viewModel.loadCena(visitID: idVisit, language: language, id: id)
                UITableView.appearance().backgroundColor = .clear
                print( self.viewModel.loadMerenda1(visitID: idVisit, language: language, id: id))
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
