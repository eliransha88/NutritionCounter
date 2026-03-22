import SwiftUI
import NutritionCore
import NutritionHome

struct ContentView: View {
    var store: any NutritionStoreProtocol

    var body: some View {
        DailyTrackerView(store: store)
    }
}

#Preview {
    ContentView(store: NutritionStore())
}
