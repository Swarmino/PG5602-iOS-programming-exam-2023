

import SwiftUI

@main
struct RatatouilleApp: App {
    @StateObject private var appearanceSettings = AppearanceSettings()
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appearanceSettings)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
