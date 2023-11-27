//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        NavigationView {
            Form {
                NavigationLink(destination: ProfileSettingView()) {
                    HStack{
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                }
                
                NavigationLink(destination: ProfileSettingView()) {
                    HStack{
                        Image(systemName: "globe.americas.fill")
                        Text("Edit countries")
                    }
                }
                
                NavigationLink(destination: ProfileSettingView()) {
                    HStack{
                        Image(systemName: "book")
                        Text("Edit categories")
                    }
                }
            }
            
        }
    }
    
}

struct ProfileSettingView: View {
    var body: some View {
        Text("ProfileView")
    }
}

struct CountrySettingView: View {
    var body: some View {
        Text("CountrySettingView")
    }
}

struct CategorySettingView: View {
    var body: some View {
        Text("CategorySettingView")
    }
}

#Preview {
    SettingsView()
}
