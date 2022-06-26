//
//  RecipeListView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 30/05/22.
//

import SwiftUI

struct RecipeListView: View {
    
    var image: String
    var nome: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                
                .overlay(alignment: .bottom, content: {
                    Rectangle()
                        .fill(Color.black)
                        .shadow(radius: 8)
                        .opacity(0.15)
                        .overlay(content: {
                            Text(nome)
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: 100)
                                .padding()
                        })
                    
                        
                        
                })
                
        }
        .frame(width: 130, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom))
         
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.blue.opacity(0.3), radius: 15, x: 0, y: 10)
         
    }
        
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(image: "Avocado", nome: "Example")
    }
}
