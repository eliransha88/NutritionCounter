import ProjectDescription

public extension Target {
    static var nutritionAppWidget: Target {
        .target(
            name: "NutritionAppWidget",
            destinations: .iOS,
            product: .appExtension,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCounter.NutritionAppWidget",
            deploymentTargets: ProjectConstants.deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "NutritionWidget",
                "NSExtension": [
                    "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
                ],
                "NSHumanReadableCopyright": "",
            ]),
            sources: ["NutritionAppWidget/Sources/**/*.swift"],
            resources: ["NutritionAppWidget/Resources/**"],
            entitlements: .file(path: "NutritionAppWidget/NutritionAppWidget.entitlements"),
            dependencies: [
                .target(name: "NutritionCore"),
            ],
            settings: .widget
        )
    }
}
