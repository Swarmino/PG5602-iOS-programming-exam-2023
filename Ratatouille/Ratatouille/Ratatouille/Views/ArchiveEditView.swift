//
//  ArchiveEditView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 01/12/2023.
//

import SwiftUI
import CoreData

struct ArchiveEditView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Meal.favourite, ascending: false),
            NSSortDescriptor(keyPath: \Meal.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: true)),
        animation: .default)
    private var meals: FetchedResults<Meal>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(meals) { meal in
                    NavigationLink {
                        Text("Meal at \(meal.name!)")
                    } label: {
                        Text("\(meal.name!)")
                    }
                }
                .onDelete(perform: deleteMeals)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteMeals(offsets: IndexSet) {
        withAnimation {
            offsets.map { meals[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ArchiveEditView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
