

import SwiftUI

struct CategoryEditView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: false)),
        animation: .default)
    private var categories: FetchedResults<Category>
    
    var body: some View {
        NavigationView {
            Form {
                if categories.isEmpty {
                    HStack{
                        Text("Ingen arkiverte kategorier")
                    }
                } else {
                    List {
                        ForEach(categories) { category in
                            Text("\(category.name!)")
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        withAnimation {
                                            archiveCategory(category: category)
                                        }
                                    } label: {
                                        Label("Arkiver", systemImage: "archivebox")
                                    }
                                    .tint(.blue)
                                }
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Rediger kategorier")
    }
    
    private func archiveCategory(category: Category) {
        category.archived = true
        try? viewContext.save()
    }
}

#Preview {
    CategoryEditView()
}
