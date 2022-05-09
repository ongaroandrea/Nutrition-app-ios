//
//  Account.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI

struct AccountView: View {
    
    var body: some View {
        VStack(spacing: 20){
            Image("logo_180")
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color("accentColor"), lineWidth: 5))
            
            Text("Andrea Ongaro")
                .font(.title)
                .foregroundColor(.black)
                
            Text("Sportivo - Calisthenics")
                .foregroundColor(.black)
                .opacity(0.45)
            
            
                NavigationView{
                    List{
                        NavigationLink {
                            Text("")
                        } label: {
                            Label {
                                Text("Modifica Dati")
                                    .foregroundColor(.black)
                                    .bold()
                                    .opacity(0.50)
                                    .padding(.horizontal, 10)
                            } icon: {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(.accentColor)
                                    .padding(10)
                                    .background(Color("light_yellow"))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.vertical, 11.0)
                        .padding(.horizontal, 11.0)
                        .listRowSeparator(.hidden)
                        
                        
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }
                
                
            
               
        }.padding(10)
        
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = .clear
        })
        .onDisappear(perform: {
            UITableView.appearance().backgroundColor = UIColor.systemBackground
        })
    }
        
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
