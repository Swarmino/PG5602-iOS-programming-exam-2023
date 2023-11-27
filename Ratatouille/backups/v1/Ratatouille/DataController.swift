//
//  DataController.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 20/11/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Ratatouille")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
