//
//  ContentView.swift
//  test
//
//  Created by Andrea  Ongaro on 25/03/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var opData: OpDat
    
    let titolo_1 : LocalizedStringKey = "titolo_1"
    let testo_1 : LocalizedStringKey = "testo_1"
    let titolo_2 : LocalizedStringKey = "titolo_2"
    let testo_2 : LocalizedStringKey = "testo_2"
    let titolo_3 : LocalizedStringKey = "titolo_3"
    let testo_3 : LocalizedStringKey = "testo_3"
    let contattami : LocalizedStringKey = "contattami"
    let contattato_giacomo : LocalizedStringKey = "contattato_giacomo"
    let testo_bottone : LocalizedStringKey = "testo_bottone"
    let frameSize = UIScreen.main.bounds.size.height < 896 ? 400 : 500
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .cyan
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.red.withAlphaComponent(0.2)
        print(frameSize)
    }
        
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 30) {
                    Text("NUTRIZIONISTA")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Secondary"))
                      
                    TabView {
                        Tab(nameImage: "first", titleImage: titolo_1, textImage: testo_1)
                        Tab(nameImage: "second", titleImage: titolo_2, textImage: testo_2)
                        Tab(nameImage: "third", titleImage: titolo_3, textImage: testo_3)
                    }
                    .frame(height: CGFloat(frameSize))
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))

                    
                    NavigationLink(destination: SigninView()) {
                        Text(contattami)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.horizontal, 55.0)
                            .padding(.vertical, 15.0)
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                            .shadow(color: .black, radius: 2)
                    }
                    
                    HStack{
                        Text(contattato_giacomo)
                            .font(.footnote)
                            .opacity(0.45)
                        
                        NavigationLink(destination: LoginView()) {
                            Text(testo_bottone)
                                .font(.footnote)
                        }
                        
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
    
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
    
    
}


