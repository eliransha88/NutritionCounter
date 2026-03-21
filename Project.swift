import ProjectDescription

// MARK: - App Target

let appTarget = Target.target(
    name: "NutritionCounter",
    destinations: .iOS,
    product: .app,
    bundleId: "com.eliransharabi.NutritionCounter",
    deploymentTargets: .iOS("18.0"),
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
        .target(name: "NutritionWidgetExtension"),
    ],
    settings: .settings(
        configurations: [
            .debug(name: "Debug", xcconfig: "Configurations/App/Debug.xcconfig"),
            .release(name: "Release", xcconfig: "Configurations/App/Release.xcconfig"),
        ]
    )
)

// MARK: - Widget Target

let widgetTarget = Target.target(
    name: "NutritionWidgetExtension",
    destinations: .iOS,
    product: .appExtension,
    bundleId: "com.eliransharabi.NutritionCounter.NutritionWidget",
    deploymentTargets: .iOS("18.0"),
    infoPlist: .extendingDefault(with: [
        "CFBundleDisplayName": "NutritionWidget",
        "NSExtension": [
            "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
        ],
        "NSHumanReadableCopyright": "",
    ]),
    sources: ["NutritionWidget/**/*.swift"],
    resources: [
        "NutritionWidget/Assets.xcassets",
        "NutritionWidget/Localizable.xcstrings",
        "NutritionWidget/PrivacyInfo.xcprivacy",
    ],
    entitlements: .file(path: "NutritionWidgetExtension.entitlements"),
    settings: .settings(
        configurations: [
            .debug(name: "Debug", xcconfig: "Configurations/Widget/Debug.xcconfig"),
            .release(name: "Release", xcconfig: "Configurations/Widget/Release.xcconfig"),
        ]
    )
)

// MARK: - Project

let project = Project(
    name: "NutritionCounter",
    organizationName: "eliransharabi",
    targets: [
        appTarget,
        widgetTarget,
    ]
)
