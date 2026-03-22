import WidgetKit
import SwiftUI

@main
struct NutritionWidgetBundle: WidgetBundle {
    var body: some Widget {
        NutritionWidget()
    }
}

struct NutritionWidget: Widget {
    let kind = "NutritionWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: NutritionWidgetProvider()) { entry in
            NutritionWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Nutrition Tracker")
        .description("Track and update your daily nutrition goals right from the home screen.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
