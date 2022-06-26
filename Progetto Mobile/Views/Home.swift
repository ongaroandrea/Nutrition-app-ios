//
//  Home.swift
//  test
//
//  Created by Andrea  Ongaro on 31/03/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowingDetailView = false
    @StateObject var viewModel: UserVM = UserVM()
    @StateObject var viewModelVisit: DietsVM = DietsVM()

    var testo_risultati: LocalizedStringKey = "testo_risultati"
    var saluti: LocalizedStringKey = "saluti"
    var visualize_diets: LocalizedStringKey = "visualize_diets"
    var scopri: LocalizedStringKey = "scopri"
    var recipes_available: LocalizedStringKey = "recipes_available"
    var visualizza: LocalizedStringKey = "visualize"
    var diet: LocalizedStringKey = "dieta"
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    VStack(spacing: 5){
                        Text(saluti.stringValue() + " " + String(viewModel.userLogged?.name ?? "test"))
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color("AccentColor"))
                        
                        Text(visualize_diets)
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                    
                    VStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.orange)
                            .opacity(0.15)
                            .frame(width: UIScreen.main.bounds.size.width - 20, height: 200)
                            .overlay(
                                HStack{
                                    HStack{
                                        Spacer()
                                        VStack(alignment: .leading, spacing: 10){
                                            Text(scopri)
                                                .foregroundColor(.red)
                                                .bold()
                                                .font(.footnote)
                                            Text(recipes_available)
                                                .foregroundColor(Color("TextColor"))
                                                .bold()
                                                .font(.title3)
                                            NavigationLink(destination: ListRecipesView(padding: -40)){
                                                Text(visualizza)
                                                    .bold()
                                                    .padding(.horizontal, 15)
                                                    .padding(.vertical, 8)
                                                    .background(Color(red: 255, green: 0, blue: 0, opacity: 0.25))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(15)
                                            }
                                        }
                                        
                                        Spacer()
                                        VStack{
                                            Image("Fruits")
                                                .resizable()
                                                .frame(width: 150, height: 150)
                                                .aspectRatio(contentMode: .fit)
                                                .font(.largeTitle)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                            )
                    }
                    
                    
                    VStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.pink)
                            .opacity(0.35)
                            .frame(width: UIScreen.main.bounds.size.width - 20, height: 100)
                            .overlay(
                                VStack {
                                    HStack{
                                        Spacer()
                                        Text(testo_risultati)
                                            .font(.title3)
                                            .foregroundColor(.white)
                                            .bold()
                                        Spacer()
                                        NavigationLink(destination: ChartsView(id: "2")){
                                            Text(visualizza)
                                                .foregroundColor(.pink)
                                                .bold()
                                                .padding(.horizontal, 15)
                                                .padding(.vertical, 8)
                                                .background(.white)
                                                .cornerRadius(15)
                                        }
                                        Spacer()
                                    }
                                }
                            )
                    }
                    
                    VStack{
                        HStack{
                            Text(diet)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(Color("TextColor"))
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.leading)
                        .padding(.top, 20)
                        .padding(.trailing)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(dietsTabItem, content: { tab in
                                    NavigationLink(destination: DietsView(viewModel: DietsVM(), id: Int64(tab.day), idVisit: viewModelVisit.lastIDVisit)){
                                        DietsButton(text: tab.text, icon: tab.icon, color: tab.color)
                                    }
                                })
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(.leading)
                }
            }
              .onAppear(perform: {
                  self.viewModel.setCurrentUser()
              })
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
