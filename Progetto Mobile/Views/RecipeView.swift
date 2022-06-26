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
            Image(viewModel.recipe?.image ?? "First")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height:300)
                .background(LinearGradient(gradient: Gradient(colors: [Color("AccentColor"), .blue]), startPoint: .top, endPoint: .bottom ))
                .padding(.bottom, 35)
            VStack(spacing:30){
                Text(viewModel.recipe?.title ?? "")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
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
                
                
                VStack(alignment: .leading, spacing: 30){
                    if viewModel.recipe?.description != "" {
                        Text(viewModel.recipe?.description ?? "")
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)

        }
        .onAppear(perform: {
            viewModel.getRecipeByID(idRecipe: id)
                
        })
        .ignoresSafeArea()
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(id: 1)
    }
    
}

