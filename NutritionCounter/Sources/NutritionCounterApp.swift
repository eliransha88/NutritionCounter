import SwiftUI
import NutritionCore

@main
struct NutritionCounterApp: App {
    @State private var store = NutritionStore()

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    store.handleAppBecameActive()
                }
        }
    }
}
