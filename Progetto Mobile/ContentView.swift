//
//  ContentView.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 02/05/22.
//

import SwiftUI

struct ContentView: View {

    let welcome:LocalizedStringKey = "welcome"
    var body: some View {
       Text(welcome)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
