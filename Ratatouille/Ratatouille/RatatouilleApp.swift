//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
