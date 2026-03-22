// Re-export KIF so every system test target only needs `import NutritionTestsHelper`
// to access both the base class and all KIF types.
@_exported import KIF
import XCTest

/// Shared base class for all KIF-driven system tests.
///
/// Subclass this instead of `KIFTestCase` to get:
/// - A Swift-compatible `tester()` method (KIF's `tester` is an Obj-C macro,
///   invisible to Swift; this wrapper recreates it using Swift's `#file`/`#line`).
/// - A single import (`import NutritionTestsHelper`) that brings in the full
///   KIF surface via `@_exported import KIF`.
open class SystemTestCase: KIFTestCase {

    /// Creates a `KIFUITestActor` anchored to the call site's source location.
    ///
    /// Equivalent to KIF's `tester` macro:
    ///   `#define tester [KIFUITestActor actorInFile:__FILE__ atLine:__LINE__ delegate:self]`
    public func tester(file: String = #file, line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}
