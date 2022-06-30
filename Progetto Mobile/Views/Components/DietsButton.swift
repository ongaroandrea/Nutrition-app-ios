//
//  DietsButton.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 09/05/22.
//

import SwiftUI

struct DietsTabItem: Identifiable {

    var id = UUID()
    var day: Int64
    var text: String
    var icon: String
    var color: Color
}

var dietsTabItem = [
    DietsTabItem(day: 1, text: "1", icon: "Fruits",
                 color: .pink.opacity(0.35)),
    DietsTabItem(day: 2, text: "2", icon: "Fruits",
                 color: .green.opacity(0.35)),
    DietsTabItem(day: 3, text: "3", icon: "Fruits",
                 color: .yellow.opacity(0.35)),
    DietsTabItem(day: 4, text: "4", icon: "Fruits", color: .teal.opacity(0.45)),
    DietsTabItem(day: 5, text: "5", icon: "Fruits", color: .brown.opacity(0.35)),
    DietsTabItem(day: 6, text: "6", icon: "Fruits", color: .gray.opacity(0.35)),
    DietsTabItem(day: 7, text: "7", icon: "Fruits", color:  .teal.opacity(0.45)),
]

struct DietsButton: View {
    //var minX: Double
    var text: String
    var icon: String
    var color: Color
    var giorno: LocalizedStringKey = "giorno"
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(color)
            .shadow(color: color, radius: 5)
            .frame(width: 150, height: 250)
            .overlay(
                VStack{
                    Image(icon)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 10)
                    Text(text + " " + giorno.stringValue())
                        .foregroundColor(.white)
                        .bold()
                    
                }
            )
    }
}


struct DietsButton_Previews: PreviewProvider {
    static var previews: some View {
        DietsButton(text: "1 Giorno", icon: "Fruits", color: .black)
    }
}

struct DietsButtonVertical: View {
    //var minX: Double
    var text: String
    var icon: String
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(color)
            .padding()
            .shadow(color: color, radius: 5)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5)
            
            .overlay(
                VStack{
                    
                    Image(icon)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 10)
                    Text(text)
                        .foregroundColor(.white)
                        .bold()
                    
                }
            )
    }
}

struct DietsButtonVertical_Previews: PreviewProvider {
    static var previews: some View {
        let giorno: LocalizedStringKey = "giorno"
        DietsButtonVertical(text: "1" + giorno.stringValue(), icon: "Fruits", color: .black)
    }
}
