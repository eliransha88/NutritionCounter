import ProjectDescription

public extension Target {
    static var nutritionCoreTests: Target {
        .target(
            name: "NutritionCoreTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCoreTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionCoreTests/**/*.swift"],
            scripts: [.cuckooGenerateAll],
            dependencies: [
                .target(name: "NutritionCore"),
                .package(product: "Cuckoo"),
            ]
        )
    }
}

// MARK: - Cuckoo 2.x mock-generation build phase

private extension TargetScript {
    /// Pre-build script that builds `CuckooGenerator` (once) from the Cuckoo
    /// SPM checkout and then runs it against the `Cuckoofile.toml` at SRCROOT.
    ///
    /// Generating all modules in a single pass keeps the three `GeneratedMocks.swift`
    /// files (Core / Home / UI) in sync whenever Core protocols change.
    static var cuckooGenerateAll: TargetScript {
        .pre(
            script: #"""
            PACKAGES_DIR="${BUILD_DIR%/Build/*}/SourcePackages"
            CUCKOO_CHECKOUT="${PACKAGES_DIR}/checkouts/Cuckoo"
            GENERATOR="${CUCKOO_CHECKOUT}/.build/release/CuckooGenerator"

            # ── Guard: packages not yet resolved ──────────────────────────────
            if [ ! -d "$CUCKOO_CHECKOUT" ]; then
                echo "warning: Cuckoo checkout not found."
                echo "warning: In Xcode choose File → Packages → Resolve Package Versions, then rebuild."
                exit 0
            fi

            # ── Build generator the first time (one-time, ~2 min) ─────────────
            if [ ! -f "$GENERATOR" ]; then
                echo "note: Building CuckooGenerator from source (first-time setup)…"
                cd "$CUCKOO_CHECKOUT"
                env -i \
                    HOME="$HOME" \
                    PATH="$PATH" \
                    DEVELOPER_DIR="${DEVELOPER_DIR:-$(xcode-select -p)}" \
                    xcrun swift build -c release --product CuckooGenerator 2>&1
                if [ ! -f "$GENERATOR" ]; then
                    echo "error: CuckooGenerator build failed. See output above."
                    exit 1
                fi
            fi

            # ── Run the generator — produces mocks for all modules ─────────────
            cd "${SRCROOT}"
            "$GENERATOR" --configuration "${SRCROOT}/Cuckoofile.toml"
            """#,
            name: "Generate Cuckoo Mocks (all modules)",
            inputPaths: [
                "$(SRCROOT)/Modules/Core/Sources",
                "$(SRCROOT)/Cuckoofile.toml",
            ],
            outputPaths: [
                "$(SRCROOT)/Tests/NutritionCoreTests/GeneratedMocks.swift",
                "$(SRCROOT)/Tests/NutritionHomeTests/GeneratedMocks.swift",
                "$(SRCROOT)/Tests/NutritionAnalyticsTests/GeneratedMocks.swift",
            ],
            basedOnDependencyAnalysis: true
        )
    }
}
