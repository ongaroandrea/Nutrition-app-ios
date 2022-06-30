//
//  RecipesView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 20/05/22.
//

import SwiftUI

struct RecipeView: View {
    
    @StateObject var viewModel: RecipeVM = RecipeVM();
    var time: LocalizedStringKey = "tempo"
    var difficolta: LocalizedStringKey = "difficolta"
    var id: Int

    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string: "")){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(viewModel.recipe?.image ?? "First")
                    .resizable()
                    .scaledToFit()
                    
            }
                
                VStack(spacing: 30){
                    Text(viewModel.recipe?.title ?? "")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    VStack(alignment: .leading, spacing: 30){
                        HStack {
                            Text(time.stringValue())
                            Text(viewModel.recipe?.time ?? "")
                        }
                        HStack {
                            Text(difficolta.stringValue())
                            ForEach((1...(viewModel.recipe?.difficulty ?? 1)), id: \.self) { _ in
                                Image(systemName: "star.fill")
                            }
                        }
                        if viewModel.recipe?.description != "" {
                            VStack(alignment: .leading, spacing: 30){
                                Text(viewModel.recipe?.description ?? "")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
        .onAppear(perform: {
            viewModel.getRecipeByID(idRecipe: id)
                
        })
        
        
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(id: 1)
    }
    
}

