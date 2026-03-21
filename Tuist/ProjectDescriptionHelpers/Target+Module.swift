import ProjectDescription

public extension Target {
    /// Creates an iOS static framework module with standard project settings.
    ///
    /// - Parameters:
    ///   - name: The target name and last component of the bundle ID.
    ///   - sources: Glob pattern(s) for Swift sources.
    ///   - resources: Optional resource file elements.
    ///   - dependencies: Other targets or packages this module depends on.
    static func module(
        name: String,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .target(
            name: name,
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "\(ProjectConstants.bundleIdPrefix).\(name)",
            deploymentTargets: ProjectConstants.deploymentTarget,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: .app
        )
    }
}
