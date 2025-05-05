# DemoSubscriptionApp
Demo iOS app offering in-app subscriptions

## Configuration

### App Store Connect

Create this app in App Store Connect, making sure the Bundle Identifier in Xcode matches the app in App Store Connect. You need to register a new identifier to do this.

#### Under the app

Added Subscription group: "Software Services"

Added Subscription: "Premium upgrade" / "org.fraune.demosubscriptionapp.premium"

- Set Subscription Duration: 1 month
- Set availability: All countries
- Set subscription price: $0.99 USD

#### Under Users and Access

Click Sandbox and add a new Apple Account, e.g. `example+sandbox1@gmail.com`.

#### Testing device

Go to iOS Settings --> Developer. Scroll to bottom and set the "Sandbox Apple Account" to the new account in App Store Connect.

#### Testing
