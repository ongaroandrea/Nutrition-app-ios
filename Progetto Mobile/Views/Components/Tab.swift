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
        VStack {
            Image(nameImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(50)
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 4, alignment: .center)
            
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
        Tab(nameImage: "first", titleImage:"Dieta", textImage: "Testo lungo")
    }
}
