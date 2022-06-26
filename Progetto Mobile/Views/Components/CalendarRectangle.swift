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
    
    @StateObject var viewModel: visitVM = visitVM()
    var body: some View {
        RoundedRectangle( cornerRadius: 10)
            
            .strokeBorder(.gray, lineWidth: 1)
            .frame(width: 300, height: 135)
            .background(Color("First"))
        
            .shadow(radius: 5)
            .overlay(
                VStack(){
                    Text("Consulto Periodico")
                        .foregroundColor(Color("TextColor"))
                        .bold()
                    
                    Text(date.formatted(.dateTime.day().month().year().hour().minute()))
                    
                    if now > date{
                        NavigationLink(destination: VisitIntro(id: self.id)){
                            Text("Mostra i risultati > ")
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
                            }
                            label: {
                                Text("Aggiungi al calendario > ")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(.mint)
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                        
                    }
                }
                .padding()
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.vertical)
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity)
    }
}

struct CalendarRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarRectangle(id: "1", date: Calendar.current.date(from: DateComponents(year: 2022, month: 5, day: 2))!)
    }
}
