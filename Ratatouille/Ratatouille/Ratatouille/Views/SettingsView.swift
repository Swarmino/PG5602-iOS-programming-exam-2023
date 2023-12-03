import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appearanceSettings: AppearanceSettings
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: AreaEditView()) {
                        Image(systemName: "globe.americas.fill")
                        Text("Rediger landomeråder")
                    }
                    NavigationLink(destination: CategoryEditView()) {
                        Image(systemName: "list.bullet.rectangle")
                        Text("Rediger kategorier")
                    }
                    NavigationLink(destination: IngredientEditView()) {
                        Image(systemName: "carrot.fill")
                        Text("Rediger ingredienser")
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "moon")
                        Toggle(isOn: $appearanceSettings.isDarkMode) {
                            Text("Dark Mode")
                        }
                        .onChange(of: appearanceSettings.isDarkMode) { _ in
                            appearanceSettings.updateAppearance()
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: ArchiveEditView()) {
                        Image(systemName: "archivebox")
                        Text("Administrere arkiv")
                    }
                }
            }.navigationTitle("Innstillinger")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AppearanceSettings())
    }
}
