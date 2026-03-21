import SwiftUI
import NutritionCore
import NutritionHome

struct ContentView: View {
    var store: NutritionStore

    var body: some View {
        DailyTrackerView(store: store)
    }
}

#Preview {
    ContentView(store: NutritionStore())
}
