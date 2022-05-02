//
//  Progetto_MobileApp.swift
//  Progetto Mobile
//
//  Created by Andrea  Ongaro on 02/05/22.
//

import SwiftUI

@main
struct Progetto_MobileApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
