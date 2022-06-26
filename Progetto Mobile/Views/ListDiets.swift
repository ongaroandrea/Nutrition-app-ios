//
//  ListDiets.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 03/06/22.
//

import SwiftUI

struct ListDiets: View {
    
    var id: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                ForEach(dietsTabItem, content: { tab in
                    NavigationLink(destination: DietsView(viewModel: DietsVM(), id: Int64(tab.day), idVisit: id)){
                        DietsButtonVertical(text: tab.text, icon: tab.icon, color: tab.color)
                    }
                    .navigationTitle("")
                    .padding(.top, -40)
                })
            }
        }
        .padding(.trailing)
    }
}

struct ListDiets_Previews: PreviewProvider {
    static var previews: some View {
        ListDiets(id: "1")
    }
}
