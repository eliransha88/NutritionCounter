#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# create-module.sh <ModuleName> [--no-generate]
#
# Scaffolds a complete NutritionCounter feature module following
# .cursor/rules/create-module.mdc
#
# Usage:
#   ./scripts/create-module.sh Analytics
#   ./scripts/create-module.sh Analytics --no-generate   # skip tuist generate
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

# ── Args ──────────────────────────────────────────────────────────────────────
NAME="${1:-}"
NO_GENERATE=false
[[ "${2:-}" == "--no-generate" ]] && NO_GENERATE=true

if [[ -z "$NAME" ]]; then
    echo "Usage: ./scripts/create-module.sh <ModuleName> [--no-generate]"
    echo "Example: ./scripts/create-module.sh Analytics"
    exit 1
fi

if ! [[ "$NAME" =~ ^[A-Z][A-Za-z0-9]+$ ]]; then
    echo "error: ModuleName must start with an uppercase letter and contain only alphanumeric characters."
    exit 1
fi

# ── Derived names ─────────────────────────────────────────────────────────────
TYPE="Nutrition${NAME}"      # NutritionAnalytics
PROP="nutrition${NAME}"      # nutritionAnalytics  (camelCase Tuist property)

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo ""
echo "┌─────────────────────────────────────────────┐"
echo "│  Creating module: ${TYPE}"
echo "└─────────────────────────────────────────────┘"
echo ""

# ── Guard: must not already exist ─────────────────────────────────────────────
if [[ -d "$ROOT/Modules/$NAME/Sources" ]]; then
    echo "error: Modules/$NAME/Sources already exists. Aborting."
    exit 1
fi

# ─────────────────────────────────────────────────────────────────────────────
# Helper: write a template file, then substitute __NAME__ / __TYPE__ / __PROP__
# ─────────────────────────────────────────────────────────────────────────────
subst() {
    sed -i '' \
        "s/__NAME__/${NAME}/g; s/__TYPE__/${TYPE}/g; s/__PROP__/${PROP}/g" \
        "$1"
}

# ─────────────────────────────────────────────────────────────────────────────
# 1. Source directory + placeholder
# ─────────────────────────────────────────────────────────────────────────────
mkdir -p "$ROOT/Modules/$NAME/Sources"

cat > "$ROOT/Modules/$NAME/Sources/${NAME}Module.swift" << 'SWIFT'
import Foundation

// __TYPE__ public types
SWIFT
subst "$ROOT/Modules/$NAME/Sources/${NAME}Module.swift"

# ─────────────────────────────────────────────────────────────────────────────
# 2. Framework Tuist target
# ─────────────────────────────────────────────────────────────────────────────
cat > "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}+Target.swift" << 'SWIFT'
import ProjectDescription

public extension Target {
    static var __PROP__: Target {
        .module(
            name: "__TYPE__",
            sources: "Modules/__NAME__/Sources/**/*.swift",
            dependencies: [
                .target(name: "NutritionCore"),
            ]
        )
    }
}
SWIFT
subst "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}+Target.swift"

# ─────────────────────────────────────────────────────────────────────────────
# 3. Unit test Tuist target
# ─────────────────────────────────────────────────────────────────────────────
cat > "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}Tests+Target.swift" << 'SWIFT'
import ProjectDescription

public extension Target {
    static var __PROP__Tests: Target {
        .target(
            name: "__TYPE__Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).__TYPE__Tests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/__TYPE__Tests/**/*.swift"],
            dependencies: [
                .target(name: "__TYPE__"),
                .target(name: "NutritionCore"),
                .package(product: "Cuckoo"),
            ]
        )
    }
}
SWIFT
subst "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}Tests+Target.swift"

# ─────────────────────────────────────────────────────────────────────────────
# 4. System test Tuist target
# ─────────────────────────────────────────────────────────────────────────────
cat > "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}SystemTests+Target.swift" << 'SWIFT'
import ProjectDescription

public extension Target {
    /// KIF-based system tests for __TYPE__.
    /// product: .unitTests — KIF is in-process; .uiTests would be out-of-process XCUITest.
    static var __PROP__SystemTests: Target {
        .target(
            name: "__TYPE__SystemTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(ProjectConstants.bundleIdPrefix).__TYPE__SystemTests",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: ["Tests/__TYPE__SystemTests/**/*.swift"],
            dependencies: [
                .target(name: "NutritionCounter"),     // host app → sets BUNDLE_LOADER/TEST_HOST
                .target(name: "NutritionTestsHelper"), // SystemTestCase + @_exported KIF
                .package(product: "KIF"),
            ],
            settings: .settings(base: ["OTHER_LDFLAGS": "$(inherited) -ObjC"])
        )
    }
}
SWIFT
subst "$ROOT/Tuist/ProjectDescriptionHelpers/Targets/${TYPE}SystemTests+Target.swift"

# ─────────────────────────────────────────────────────────────────────────────
# 5. Test source directories + placeholder files
# ─────────────────────────────────────────────────────────────────────────────
mkdir -p "$ROOT/Tests/${TYPE}Tests"
mkdir -p "$ROOT/Tests/${TYPE}SystemTests"

# GeneratedMocks placeholder (overwritten by Cuckoo build phase at first build)
cat > "$ROOT/Tests/${TYPE}Tests/GeneratedMocks.swift" << 'SWIFT'
// Cuckoo-generated mocks — do not edit by hand.
// This file is overwritten by the NutritionCoreTests pre-build phase.
import Cuckoo
@testable import NutritionCore
SWIFT

# Unit test placeholder
cat > "$ROOT/Tests/${TYPE}Tests/${NAME}Tests.swift" << 'SWIFT'
import XCTest
import Cuckoo
@testable import __TYPE__

final class __NAME__Tests: XCTestCase {

    // MARK: - Lifecycle

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - TODO: Add unit tests for __TYPE__

    func test_placeholder() throws {
        // GIVEN/WHEN: Replace with real setup
        // THEN: Replace with real assertion
        XCTAssertTrue(true, "Replace with real tests")
    }
}
SWIFT
subst "$ROOT/Tests/${TYPE}Tests/${NAME}Tests.swift"

# System test placeholder
cat > "$ROOT/Tests/${TYPE}SystemTests/${NAME}SystemTests.swift" << 'SWIFT'
import NutritionTestsHelper

/// KIF system tests for __TYPE__.
/// Inherits `tester()` from SystemTestCase — no `import KIF` needed.
final class __NAME__SystemTests: SystemTestCase {

    // MARK: - TODO: Add KIF system tests for __TYPE__

    func testApp_Placeholder() {
        // GIVEN: The app is running
        // WHEN: <describe the action>
        // THEN: <describe the expectation>
        tester().waitForView(withAccessibilityLabel: "Protein")
    }
}
SWIFT
subst "$ROOT/Tests/${TYPE}SystemTests/${NAME}SystemTests.swift"

# ─────────────────────────────────────────────────────────────────────────────
# 6a. Cuckoofile.toml — append new module block
# ─────────────────────────────────────────────────────────────────────────────
cat >> "$ROOT/Cuckoofile.toml" << TOML

[modules.NutritionCoreFor${NAME}]
output = "Tests/${TYPE}Tests/GeneratedMocks.swift"
testableImports = ["NutritionCore"]
sources = [
    "Modules/Core/Sources/**/*.swift",
]

[modules.NutritionCoreFor${NAME}.options]
protocolsOnly = true
TOML

# ─────────────────────────────────────────────────────────────────────────────
# 6b. NutritionCoreTests+Target.swift — add new outputPath so the Cuckoo
#     generate script produces GeneratedMocks.swift for this module too.
# ─────────────────────────────────────────────────────────────────────────────
CORE_TESTS_TARGET="$ROOT/Tuist/ProjectDescriptionHelpers/Targets/NutritionCoreTests+Target.swift"

python3 - "$CORE_TESTS_TARGET" "$TYPE" << 'PYEOF'
import sys, re

filepath, module_type = sys.argv[1], sys.argv[2]
new_path = f'                "$(SRCROOT)/Tests/{module_type}Tests/GeneratedMocks.swift",'

with open(filepath) as f:
    content = f.read()

# Insert before the closing `            ],` of the outputPaths array
content = re.sub(
    r'((?:[ \t]+"[^"]+GeneratedMocks\.swift",\n)+)([ \t]+\],)',
    lambda m: m.group(1) + new_path + '\n' + m.group(2),
    content
)

with open(filepath, 'w') as f:
    f.write(content)

print("  ✓  NutritionCoreTests+Target.swift — outputPaths updated")
PYEOF

# ─────────────────────────────────────────────────────────────────────────────
# 7. Project.swift — register all four new targets
# ─────────────────────────────────────────────────────────────────────────────
python3 - "$ROOT/Project.swift" "$TYPE" "$PROP" << 'PYEOF'
import sys, re

filepath, module_type, prop = sys.argv[1], sys.argv[2], sys.argv[3]

new_block = (
    f'\n\n        // MARK: - {module_type} tests\n'
    f'        .{prop},\n'
    f'        .{prop}Tests,\n'
    f'        .{prop}SystemTests,'
)

with open(filepath) as f:
    content = f.read()

# Find the last .nutrition*SystemTests, that is immediately followed by \n    ]
# and insert the new block between them.
content = re.sub(
    r'(        \.nutrition\w+SystemTests,)(\n    \])',
    lambda m: m.group(1) + new_block + m.group(2),
    content
)

with open(filepath, 'w') as f:
    f.write(content)

print("  ✓  Project.swift — targets registered")
PYEOF

# ─────────────────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo "  ✓  Modules/${NAME}/Sources/${NAME}Module.swift"
echo "  ✓  Tuist/ProjectDescriptionHelpers/Targets/${TYPE}+Target.swift"
echo "  ✓  Tuist/ProjectDescriptionHelpers/Targets/${TYPE}Tests+Target.swift"
echo "  ✓  Tuist/ProjectDescriptionHelpers/Targets/${TYPE}SystemTests+Target.swift"
echo "  ✓  Tests/${TYPE}Tests/GeneratedMocks.swift"
echo "  ✓  Tests/${TYPE}Tests/${NAME}Tests.swift"
echo "  ✓  Tests/${TYPE}SystemTests/${NAME}SystemTests.swift"
echo "  ✓  Cuckoofile.toml — module appended"
echo ""

if [[ "$NO_GENERATE" == true ]]; then
    echo "  ⏭  Skipping tuist generate (--no-generate)"
else
    echo "  ▸  Running tuist generate…"
    cd "$ROOT" && tuist generate
fi

echo ""
echo "  ✅  ${TYPE} is ready."
echo "      Next: fill in Modules/${NAME}/Sources/ and flesh out the test placeholders."
echo ""
