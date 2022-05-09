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
    MenuTabItem(text: "Learn Now", icon: "house", tab: .home, color: .teal),
    MenuTabItem(text: "Explore", icon: "magnifyingglass", tab: .explore, color: .teal),
    MenuTabItem(text: "Notification", icon: "house", tab: .notifications, color: .teal),
    MenuTabItem(text: "Library", icon: "house", tab: .library, color: .teal)
]

enum MenuTab:String {
    case home
    case explore
    case notifications
    case library
}
