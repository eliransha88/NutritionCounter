import SwiftUI
import Charts
import NutritionCore

struct NutrientConfig: Sendable {
    let type: NutrientType
    let color: Color
    let symbol: BasicChartSymbolShape
}
