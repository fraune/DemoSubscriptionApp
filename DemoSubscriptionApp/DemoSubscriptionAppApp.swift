//
//  DemoSubscriptionAppApp.swift
//  DemoSubscriptionApp
//
//  Created by Brandon Fraune on 5/4/25.
//

import SwiftUI

@main
struct DemoSubscriptionAppApp: App {
    @StateObject private var subscriptionManager = SubscriptionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subscriptionManager)
                .task {
                    // On launch: fetch products & current status
                    await subscriptionManager.fetchProducts()
                    await subscriptionManager.updateSubscriptionStatus()
                }
        }
    }
}
