//
//  Tab.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import SwiftUI

struct Tab: View {
    
    var nameImage: String
    var titleImage: LocalizedStringKey
    var textImage: LocalizedStringKey
    
    var body: some View {
        VStack (spacing: 30){
            Image(nameImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(50)
                .frame(width: 250, height: 250, alignment: .center)
            
            Text(titleImage)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                
                
            Text(textImage)
                .multilineTextAlignment(.center)
                .opacity(0.45)
        }
        .padding(.horizontal, 25)
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab(nameImage: "image_1",titleImage:"Dieta", textImage: "Testo lungo")
    }
}
