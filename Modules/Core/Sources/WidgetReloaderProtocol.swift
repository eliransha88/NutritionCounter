import WidgetKit

/// Abstracts the WidgetKit reload API so `NutritionStore` can be unit-tested
/// without triggering live inter-process communication.
public protocol WidgetReloaderProtocol: Sendable {
    func reloadTimelines(ofKind kind: String)
}

/// Production implementation — delegates to `WidgetCenter.shared`.
public struct LiveWidgetReloader: WidgetReloaderProtocol {
    public init() {}

    public func reloadTimelines(ofKind kind: String) {
        WidgetCenter.shared.reloadTimelines(ofKind: kind)
    }
}

/// Test/preview stub — silently discards reload requests.
public struct NoOpWidgetReloader: WidgetReloaderProtocol {
    public init() {}

    public func reloadTimelines(ofKind kind: String) {}
}
