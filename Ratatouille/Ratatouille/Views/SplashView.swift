//
//  SplashView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isFadedOut = false

    var body: some View {
        NavigationView {
            ZStack {
                // Fading View
                VStack {
                    Image("temp-test").resizable()
                    Text("SplashView").font(.title)
                }
                .opacity(isFadedOut ? 0 : 1)
                .onAppear {
                    // Use DispatchQueue to delay the animation by 3 seconds
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        withAnimation {
//                            self.isFadedOut = true
//                        }
//                    }
                }

                // New View (Rendered after fade-out)
                NavigationLink(
                    destination: NewView(),
                    isActive: $isFadedOut,
                    label: {
                        EmptyView()
                    }
                )
            }
            .navigationBarHidden(true)
        }
    }
}

struct NewView: View {
    var body: some View {
        VStack {
            Text("New View")
        }
    }
}

#Preview {
    SplashView()
}
