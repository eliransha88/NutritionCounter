import ProjectDescription

public extension Target {
    static var nutritionCounterTests: Target {
        .target(
            name: "NutritionCounterTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).NutritionCounterTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/NutritionCounterTests/**/*.swift"],
            scripts: [.cuckooGenerate],
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
    /// Cuckoo 2.x notes:
    /// • The root `Package.swift` declares `CuckooGenerator` as an executable
    ///   target — it must be built from the **checkout root**, not `Generator/`.
    /// • The 2.x CLI takes a `Cuckoofile.toml` config file; there are no longer
    ///   `--testable`, `--output`, or positional-file arguments.
    /// • `env -i` strips Xcode's `SDKROOT=iPhoneSimulator` so SPM's manifest
    ///   parser doesn't inherit it when spawning child processes.
    static var cuckooGenerate: TargetScript {
        .pre(
            script: #"""
            PACKAGES_DIR="${BUILD_DIR%/Build/*}/SourcePackages"
            CUCKOO_CHECKOUT="${PACKAGES_DIR}/checkouts/Cuckoo"
            # Cuckoo 2.x: binary is built from the checkout root, not Generator/
            GENERATOR="${CUCKOO_CHECKOUT}/.build/release/CuckooGenerator"

            # ── Guard: packages not yet resolved ──────────────────────────────
            if [ ! -d "$CUCKOO_CHECKOUT" ]; then
                echo "warning: Cuckoo checkout not found."
                echo "warning: In Xcode choose File → Packages → Resolve Package Versions, then rebuild."
                exit 0
            fi

            # ── Build generator the first time (one-time, ~2 min) ─────────────
            # cd to the CHECKOUT ROOT — that is where Package.swift lives in 2.x.
            # env -i strips SDKROOT so SPM sub-processes don't inherit the iOS SDK.
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

            # ── Run the generator using Cuckoofile.toml ────────────────────────
            cd "${SRCROOT}"
            "$GENERATOR" --configuration "${SRCROOT}/Cuckoofile.toml"
            """#,
            name: "Generate Cuckoo Mocks",
            inputPaths: [
                // Whole Core Sources directory — any new protocol file triggers a re-run
                "$(SRCROOT)/Modules/Core/Sources",
                "$(SRCROOT)/Cuckoofile.toml",
            ],
            outputPaths: [
                "$(SRCROOT)/Tests/NutritionCounterTests/GeneratedMocks.swift",
            ],
            basedOnDependencyAnalysis: true
        )
    }
}
