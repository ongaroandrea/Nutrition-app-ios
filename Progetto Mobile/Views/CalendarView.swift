//
//  Calendar.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI

struct CalendarView: View {
    
    let textLoc : LocalizedStringKey = "welcome"
    var body: some View {
        VStack{
            Text(textLoc)
                .font(.title)
                .foregroundColor(Color("light_blue"))
                .bold()
            
            VStack{
                RoundedRectangle( cornerRadius: 10)
                    
                    .strokeBorder(.gray, lineWidth: 1)
                    .frame(width: 300, height: 135)
                    .background(Color("light_blue"))
                
                    .shadow(radius: 5)
                    .overlay(
                        VStack(alignment: .leading){
                            Text("Consulto Periodico")
                                .bold()
                            
                            Text("Data: 26/02")
                            
                            Text("Aggiungi al calendario > ")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.mint)
                                .cornerRadius(10)
                        }
                    )
                    .padding(.vertical)
                RoundedRectangle( cornerRadius: 10)
                    .strokeBorder(.gray, lineWidth: 1)
                    .frame(width: 300, height: 100)
                    .background(Color("light_blue"))
                    .shadow(radius: 10)
                    .overlay(
                        VStack(alignment: .leading){
                            Text("Consulto Periodico")
                                .bold()
                            
                            Text("Data: 26/02")
                            
                            Text("Aggiungi al calendario > ")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(.mint)
                                .cornerRadius(10)
                        }
                    )
                
            }
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
