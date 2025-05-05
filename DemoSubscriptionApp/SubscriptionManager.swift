//
//  SubscriptionManager.swift
//  DemoSubscriptionApp
//
//  Created by Brandon Fraune on 5/4/25.
//

import Foundation
import StoreKit

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var isSubscribed = false

    private let productIDs = ["org.fraune.demosubscriptionapp.premium"]

    init() {
        listenForTransactions()
    }

    /// 1. Fetch the product metadata from App Store Connect
    func fetchProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Failed fetching products: \(error)")
        }
    }

    /// 2. Initiate a purchase
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            if case .success(let verification) = result,
               case .verified = verification {
                await updateSubscriptionStatus()
            }
        } catch {
            print("Purchase failed: \(error)")
        }
    }

    /// 3. Check current entitlements
    func updateSubscriptionStatus() async {
        for await verificationResult in Transaction.currentEntitlements {
            switch verificationResult {
            case .verified(let transaction):
                if productIDs.contains(transaction.productID) {
                    isSubscribed = true
                    return
                }
            case .unverified:
                continue
            }
        }
        isSubscribed = false
    }

    /// 4. Listen for any future transaction updates
    private func listenForTransactions() {
        Task.detached { [weak self] in
            for await _ in Transaction.updates {
                await self?.updateSubscriptionStatus()
            }
        }
    }
}
