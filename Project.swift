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
        base: [
            "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
            "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
            "SWIFT_STRICT_CONCURRENCY": "targeted",
            "SWIFT_EMIT_LOC_STRINGS": "YES",
            "ENABLE_PREVIEWS": "YES",
            "DEVELOPMENT_ASSET_PATHS": "\"NutritionCounter/Preview Content\"",
            "MARKETING_VERSION": "1.0",
            "CURRENT_PROJECT_VERSION": "1",
            "SUPPORTED_PLATFORMS": "iphoneos iphonesimulator",
            "SUPPORTS_MACCATALYST": "NO",
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
        base: [
            "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
            "ASSETCATALOG_COMPILER_WIDGET_BACKGROUND_COLOR_NAME": "WidgetBackground",
            "SWIFT_STRICT_CONCURRENCY": "targeted",
            "SWIFT_APPROACHABLE_CONCURRENCY": "YES",
            "SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY": "YES",
            "SWIFT_EMIT_LOC_STRINGS": "YES",
            "SKIP_INSTALL": "YES",
            "MARKETING_VERSION": "1.0",
            "CURRENT_PROJECT_VERSION": "1",
        ]
    )
)

// MARK: - Project

let project = Project(
    name: "NutritionCounter",
    organizationName: "eliransharabi",
    settings: .settings(
        base: [
            "LOCALIZATION_PREFERS_STRING_CATALOGS": "YES",
            "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
            "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
            "DEAD_CODE_STRIPPING": "YES",
        ]
    ),
    targets: [
        appTarget,
        widgetTarget,
    ]
)
