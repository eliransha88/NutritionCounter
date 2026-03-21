import ProjectDescription

public extension Target {
    static var nutritionCounter: Target {
        .target(
            name: "NutritionCounter",
            destinations: .iOS,
            product: .app,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCounter",
            deploymentTargets: ProjectConstants.deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "Nutrition Counter",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                ],
                "UILaunchScreen": [:],
                "UIStatusBarStyle": "UIStatusBarStyleDefault",
                "UIApplicationSupportsIndirectInputEvents": true,
                "UISupportedInterfaceOrientations": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight",
                ],
                "UISupportedInterfaceOrientations~ipad": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationPortraitUpsideDown",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight",
                ],
            ]),
            sources: ["NutritionCounter/**/*.swift"],
            resources: [
                "NutritionCounter/Assets.xcassets",
                "NutritionCounter/Localizable.xcstrings",
                "NutritionCounter/InfoPlist.xcstrings",
                "NutritionCounter/PrivacyInfo.xcprivacy",
            ],
            entitlements: .file(path: "NutritionCounter/NutritionCounter.entitlements"),
            dependencies: [
                .target(name: "NutritionAppWidget"),
                .target(name: "NutritionHome"),
                .target(name: "NutritionCore"),
            ],
            settings: .app
        )
    }
}
