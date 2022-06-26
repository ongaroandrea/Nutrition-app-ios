//
//  Calendar.swift
//  test
//
//  Created by Andrea  Ongaro on 27/03/22.
//

import SwiftUI

struct CalendarView: View {
    
    let textLoc : LocalizedStringKey = "welcome"
    @State var isCreatePresented = false
    @StateObject var viewModel: visitVM = visitVM()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Text("Calendario Appuntamenti")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Primary"))
                
                List {
                    ForEach(viewModel.listVisits){ visit in
                        CalendarRectangle(id: visit.id, date: visit.date)
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
                        CreateVisit(visitManager: viewModel, isPresented: self.$isCreatePresented)
                    }
                    .accentColor(.primary)
                }
            }
            .onAppear(perform: {
                self.viewModel.getAllVisitByUserID()                
            })
            .navigationTitle("")
            .padding(.top, -40)
        }
        .frame(width: .infinity, height: .infinity, alignment: .topLeading)
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
