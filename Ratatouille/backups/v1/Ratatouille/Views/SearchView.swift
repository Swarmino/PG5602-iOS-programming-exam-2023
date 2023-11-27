//
//  SearchView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        VStack{
            SearchResultView()
            Spacer()
            SearchBarView()
        }
        
        
    }
}

struct SearchBarView: View {
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10).foregroundColor(.gray)
                TextField("Search", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/).padding().foregroundColor(.white)
            }
            .frame(height: 50)
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                Button("Search") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
            }.frame(width: 100, height: 50)
        }.padding()
    }
}

struct SearchResultView: View {
    
    @State var hasSearched: Bool = false
    
    var body: some View {
        if (!hasSearched){
            VStack{
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                Text("No results")
                Spacer()
            }.opacity(0.2)
        } else {
            ResultView()
        }
    }
}

struct ResultView: View {
    var body: some View {
        Text("Yes")
    }
}

#Preview {
    SearchView()
        //.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
