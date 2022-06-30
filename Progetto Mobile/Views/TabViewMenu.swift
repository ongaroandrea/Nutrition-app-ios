//
//  TabViewMenu.swift
//  test
//
//  Created by Andrea  Ongaro on 26/03/22.
//

import SwiftUI

//https://www.youtube.com/watch?v=Y4Tc-68d5BE
struct TabViewMenuView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject private var opdata: OpDat
    @State var selectedTab: MenuTab = .home
    @State var color:Color = .gray
    var impostazioni: LocalizedStringKey = "impostazioni"
    var visite: LocalizedStringKey = "visite"
    var sensazioni: LocalizedStringKey = "sensazioni"
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
            ListSensationView()
                .tabItem {
                    Label(sensazioni.stringValue(), systemImage: "scribble")
                }
            CalendarView()
                .tabItem {
                    Label(visite.stringValue(), systemImage: "calendar")
                }
            SettingsView()
                .tabItem {
                    Label(impostazioni.stringValue(), systemImage: "gear")
                }
                .environmentObject(opdata)
                .environmentObject(authenticationManager)
        }
        
        
        
        
    }
}

struct TabViewMenu_Previews: PreviewProvider {
    static var previews: some View {
        TabViewMenuView()
            .environmentObject(OpDat())
            .environmentObject(AuthenticationManager())
    }
}
