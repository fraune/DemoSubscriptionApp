//
//  ContentView.swift
//  DemoSubscriptionApp
//
//  Created by Brandon Fraune on 5/4/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Group {
                if subscriptionManager.isSubscribed {
                    // 🎉 Premium UI
                    Text("Welcome, premium user!")
                    // ...show unlocked features here...
                } else if let premium = subscriptionManager.products.first {
                    // 🛒 Purchase button
                    Button("Subscribe for \(premium.displayPrice)") {
                        Task { await subscriptionManager.purchase(premium) }
                    }
                } else {
                    // 🔄 Loading state
                    ProgressView()
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
