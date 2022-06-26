//
//  MenuTab.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 05/05/22.
//

import SwiftUI

struct MenuTabItem: Identifiable {
    
    var id = UUID()
    var text: String
    var icon: String
    var tab: MenuTab
    var color: Color
}

var menuTabItem = [
    MenuTabItem(text: "Home", icon: "house", tab: MenuTab.home, color: .teal),
    MenuTabItem(text: "Ricette", icon: "magnifyingglass", tab: MenuTab.riceps, color: .orange),
    MenuTabItem(text: "Calendario", icon: "calendar", tab: MenuTab.calendar, color: .red),
    MenuTabItem(text: "Impostazioni", icon: "gear", tab: MenuTab.settings, color: .gray)
]

enum MenuTab:String {
    case home
    case riceps
    case calendar
    case settings
}
