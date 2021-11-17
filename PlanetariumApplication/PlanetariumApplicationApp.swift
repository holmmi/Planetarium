//
//  PlanetariumApplicationApp.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 17.11.2021.
//

import SwiftUI

@main
struct PlanetariumApplicationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
