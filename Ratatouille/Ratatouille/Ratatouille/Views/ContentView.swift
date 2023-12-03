//
//  ContentView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 27/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let appearanceSettings = AppearanceSettings()
    
    var body: some View {
        MainView()
            .onAppear{
                appearanceSettings.updateAppearance()
            }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
