import ProjectDescription

public extension Settings {
    /// Debug + Release configurations backed by `Configurations/App/`.
    /// Used by the app target and all static framework modules.
    static var app: Settings {
        .settings(
            base: [
                // Baked into the pbxproj so framework targets generate
                // GeneratedStringSymbols_*.swift from their .xcstrings resources.
                "SWIFT_EMIT_LOC_STRINGS": "YES",
                "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
            ],
            configurations: [
                .debug(name: "Debug",   xcconfig: "Configurations/App/Debug.xcconfig"),
                .release(name: "Release", xcconfig: "Configurations/App/Release.xcconfig"),
            ]
        )
    }

    /// Debug + Release configurations backed by `Configurations/Widget/`.
    /// Used by the widget extension target.
    static var widget: Settings {
        .settings(
            base: [
                "SWIFT_EMIT_LOC_STRINGS": "YES",
                "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
            ],
            configurations: [
                .debug(name: "Debug",   xcconfig: "Configurations/Widget/Debug.xcconfig"),
                .release(name: "Release", xcconfig: "Configurations/Widget/Release.xcconfig"),
            ]
        )
    }
}
