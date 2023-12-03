

import SwiftUI

struct AreaEditView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Area.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: false)),
        animation: .default)
    private var areas: FetchedResults<Area>
    
    var body: some View {
        NavigationView {
            Form {
                if areas.isEmpty {
                    HStack{
                        Text("Ingen arkiverte områder")
                    }
                } else {
                    List {
                        ForEach(areas) { area in
                            Text("\(area.name!)")
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        withAnimation {
                                            archiveArea(area: area)
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
        .navigationTitle("Rediger områder")
    }
    func archiveArea(area: Area) {
        area.archived = true
        try? viewContext.save()
    }
}

#Preview {
    AreaEditView()
}
