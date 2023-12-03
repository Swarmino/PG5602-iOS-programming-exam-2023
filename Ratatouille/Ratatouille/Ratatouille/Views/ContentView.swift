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
        ZStack{
            Rectangle()
                .foregroundColor(.ratBlue)
                .ignoresSafeArea()
            Image("Ratatouille Logo")
                .resizable()
                .scaledToFit()
        }
        .frame(height: 100, alignment: .center)
        MainView()
            .onAppear{
                appearanceSettings.updateAppearance()
            }
            .overlay(
                JumpingImageAnimation()
            )
    }
}

struct JumpingImageAnimation: View {
    @State private var Food2yOffset: CGFloat = -1000
    @State private var Food1yOffset: CGFloat = -1500
    @State private var yOffset: CGFloat = -700
    @State private var opacity: Double = 2.0
    
    var body: some View {
        ZStack {
            ZStack{
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                    .scaleEffect(2)
                    .opacity(opacity)
                Image("Ratatouille Logo")
                    .resizable()
                    .scaledToFit()
                    .opacity(opacity)
            }
            .animation(
                Animation.linear(duration: 2)
                    .repeatCount(1, autoreverses: true)
            )
            .onAppear {
                withAnimation {
                    self.opacity = 0
                }
            }
            
            VStack {
                Spacer()
                
                Image("rat_food")
                    .resizable()
                    .scaledToFit()
                    .offset(x: 90, y: Food1yOffset)
                    .animation(
                        Animation.linear(duration: 3)
                            .repeatCount(1, autoreverses: true)
                    )
                    .onAppear {
                        withAnimation {
                            self.Food1yOffset = UIScreen.main.bounds.height
                        }
                    }
                
                Image("rat_food2")
                    .resizable()
                    .scaledToFit()
                    .offset(x: -120, y: Food2yOffset)
                    .animation(
                        Animation.linear(duration: 2)
                            .repeatCount(1, autoreverses: true)
                    )
                    .onAppear {
                        withAnimation {
                            self.Food2yOffset = UIScreen.main.bounds.height
                        }
                    }
                
                Image("rat_jump")
                    .resizable()
                    .scaledToFit()
                    .offset(y: yOffset)
                    .animation(
                        Animation.easeInOut(duration: 3)
                            .repeatCount(1, autoreverses: true)
                    )
                    .onAppear {
                        withAnimation {
                            self.yOffset = UIScreen.main.bounds.height
                        }
                    }
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
