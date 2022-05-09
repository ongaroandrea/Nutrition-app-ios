//
//  Home.swift
//  test
//
//  Created by Andrea  Ongaro on 31/03/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(spacing: 5){
                Text("Ciao Andrea Ongaro,")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("light_blue"))
                    
                Text("visualizza la tua dieta qui")
                    .font(.footnote)
                    .bold()
                    .foregroundColor(.gray)
            }
            .padding(.top, 20)
            
            VStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.orange)
                    .opacity(0.15)
                    .frame(width: 360, height: 200)
                    .overlay(
                        HStack{
                            HStack{
                                VStack(alignment: .leading, spacing: 10){
                                    Text("SCOPRI")
                                        .foregroundColor(.red)
                                        .bold()
                                        .font(.footnote)
                                    Text("Le ricette disponibili")
                                        .foregroundColor(.black)
                                        .bold()
                                    Button{
                                        print("action")
                                    } label: {
                                        Text("Visualizza")
                                            .bold()
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 8)
                                            .background(.red)
                                            .opacity(0.25)
                                            .foregroundColor(.red)
                                            .cornerRadius(15)
                                        
                                    }
                                }
                                
                                VStack{
                                    Image(systemName: "brain")
                                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                                }
                                
                            }
                        }
                    )
            }
            
           
            VStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.pink)
                    .opacity(0.35)
                    .frame(width: 360, height: 100)
                    .overlay(
                        VStack {
                            HStack{
                                Text("Monitora i tuoi risultati")
                                    .foregroundColor(.white)
                                    .bold()
                                
                                Button{
                                    print("action")
                                } label: {
                                    Text("Visualizza")
                                        .bold()
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 8)
                                        .background(.white)
                                        .cornerRadius(15)
                                    
                                }
                            }
                            
                            
                        }
                    )
            }
            
            VStack{
                HStack{
                        Text("Dieta")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(.title)
                    }
                }
                .foregroundColor(.black)
                .padding(.leading)
                .padding(.top, 20)
                .padding(.trailing)
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 15){
                        GeometryReader{ geometry in
                            RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(.blue)
                                            .shadow(color: .blue, radius: 5)                                            //.opacity(0.15)
                                            .frame(width: 150, height: 250)
                                            .overlay(
                                                VStack{
                                                    Image(systemName: "sunrise.fill")
                                                        .foregroundColor(.black)
                                                        .font(.title)
                                                        .padding(.bottom, 10)
                                                    Text("1 Giorno")
                                                        .bold()
                                                        
                                                }
                                            )
                                            .onTapGesture {
                                                print("clicled")
                                            }
                                            .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -20), axis: (x:0, y: 10.0, z:0))
                            
                            
                        }
                    }
                }
                .padding(.leading)
            }
        }
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
