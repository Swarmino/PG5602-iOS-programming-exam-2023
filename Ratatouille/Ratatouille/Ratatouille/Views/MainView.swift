
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            RecipeView().tabItem{
                Label("Oppskrifter", systemImage: "book.pages")
            }
            SearchView().tabItem{
                Label("Søk", systemImage: "magnifyingglass")
            }
            SettingsView().tabItem{
                Label("Innstillinger", systemImage: "gearshape")
            }
        }.accentColor(.ratBlue)
    }
}

#Preview {
    MainView()
}
