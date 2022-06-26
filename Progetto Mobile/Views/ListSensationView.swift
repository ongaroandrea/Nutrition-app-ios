//
//  ListSensation.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 25/06/22.
//

import SwiftUI

struct ListSensationView: View {
    
    @StateObject var viewModel: SensationVM = SensationVM()
    @State var isCreatePresented = false
    var body: some View {
        NavigationView(content: {
            VStack(spacing: 10){
                Text("Lista Sensazioni")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("AccentColor"))
                List {
                    ForEach(viewModel.listSensation){ sensation in
                        NavigationLink(destination: SensationView(id: sensation.id)){
                            Text(sensation.date.formatted())
                        }
                    }
                }
                .listStyle(.plain)
                .navigationBarItems(trailing: Button {
                    self.isCreatePresented.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                })
                .sheet(isPresented: $isCreatePresented) {
                    NavigationView {
                        CreateSensationView()
                    }
                    .accentColor(.primary)
                }
            }
            .onAppear(perform: {
                viewModel.loadAll()
                
            })
            .navigationTitle("")
            .padding(.top, -40)
            
        })
    }
}

struct ListSensationView_Previews: PreviewProvider {
    static var previews: some View {
        ListSensationView()
    }
}
