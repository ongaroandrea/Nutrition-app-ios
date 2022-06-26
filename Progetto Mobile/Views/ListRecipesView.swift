//
//  ListRecipesView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 04/06/22.
//

import SwiftUI

struct ListRecipesView: View {
    
    @StateObject var viewModel: RecipeVM = RecipeVM()
    var recipes: LocalizedStringKey = "recipes_available"
    var padding: CGFloat
    var body: some View {
            VStack(spacing: 10){
                Text(recipes)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("AccentColor"))
                ScrollView{
                        VStack{
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15) {
                                ForEach(viewModel.listRecips, content: { recipe in
                                    NavigationLink(destination: RecipeView(id: Int(recipe.id))){
                                        RecipeListView(image: recipe.image, nome: recipe.title)
                                    }
                                    
                                })
                            }
                        }
                }
            }
            .onAppear(perform: {
                viewModel.loadAll()
                
            })
            .padding(.top, padding)
                 
        
    }
}

struct ListRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipesView(padding: 40)
    }
}
