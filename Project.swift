import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Modules

let coreModule = Target.module(
    name: "NutritionCore",
    sources: "Modules/Core/Sources/**/*.swift"
)

let uiModule = Target.module(
    name: "NutritionUI",
    sources: "Modules/UI/Sources/**/*.swift",
    dependencies: [.target(name: "NutritionCore")]
)

let homeModule = Target.module(
    name: "NutritionHome",
    sources: "Modules/Home/Sources/**/*.swift",
    dependencies: [
        .target(name: "NutritionCore"),
        .target(name: "NutritionUI"),
    ]
)

// MARK: - App Target

let appTarget = Target.target(
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

// MARK: - Widget Target

let widgetTarget = Target.target(
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
    sources: ["NutritionAppWidget/**/*.swift"],
    resources: [
        "NutritionAppWidget/Assets.xcassets",
        "NutritionAppWidget/Localizable.xcstrings",
        "NutritionAppWidget/PrivacyInfo.xcprivacy",
    ],
    entitlements: .file(path: "NutritionAppWidget.entitlements"),
    dependencies: [
        .target(name: "NutritionCore"),
    ],
    settings: .widget
)

// MARK: - Project

let project = Project(
    name: "NutritionCounter",
    organizationName: ProjectConstants.organizationName,
    targets: [
        coreModule,
        uiModule,
        homeModule,
        appTarget,
        widgetTarget,
    ]
)
