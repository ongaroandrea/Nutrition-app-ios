//
//  CalendarRectangle.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 09/05/22.
//

import SwiftUI

struct CalendarRectangle: View {
    var id: String
    var date: Date
    let now = Date()
    let consulto : LocalizedStringKey = "consulto"
    let risultati : LocalizedStringKey = "risultati"
    let aggiungi_calendario : LocalizedStringKey = "aggiungi_calendario"
    @StateObject var viewModel: visitVM = visitVM()
    @State var success = false
    @State var error = false
    var error_text : LocalizedStringKey = "errore"
    var success_text : LocalizedStringKey = "successo"
    var body: some View {
        RoundedRectangle( cornerRadius: 10)
            .strokeBorder(.gray, lineWidth: 1)
            .frame(width: 300, height: 135)
            .background(Color("First"))
        
            .shadow(radius: 5)
            .overlay(
                VStack(){
                    Text(consulto.stringValue())
                        .foregroundColor(Color("TextColor"))
                        .bold()
                    
                    Text(date.formatted(.dateTime.day().month().year().hour().minute()))
                    
                    if now > date{
                        NavigationLink(destination: VisitIntro(id: self.id)){
                            Text(risultati.stringValue())
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.mint)
                                .cornerRadius(10)
                        }
                    } else {
                        HStack{
                            Button{
                                print("Cerco di aggiungerlo al calendario")
                                viewModel.generateEvent(id: id)
                                
                                if viewModel.status {
                                    self.error = false
                                    self.success = true
                                } else {
                                    self.error = true
                                    self.success = false
                                }
                                print(viewModel.status)
                                print(self.success)
                            }
                            label: {
                                Text(aggiungi_calendario.stringValue())
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(.mint)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                        }
                        .alert(isPresented: $success) {
                            Alert(title: Text(success_text.stringValue()), message: Text("valori_modificati.stringValue()"), dismissButton: .default(Text("Ok!")))
                        }
                    }
                }
                .padding()
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.vertical)
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity)
            .alert(isPresented: $error) {
                Alert(title: Text(error_text.stringValue()), message: Text("valori_modificati.stringValue()"), dismissButton: .default(Text("Ok!")))
            }
            
    }
}

struct CalendarRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRectangle(id: "1", date: Calendar.current.date(from: DateComponents(year: 2022, month: 5, day: 2))!)
    }
}
