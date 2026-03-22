import ProjectDescription

public extension Package {
    static var cuckoo: Package {
        .remote(
            url: "https://github.com/Brightify/Cuckoo",
            requirement: .upToNextMajor(from: "2.2.1")
        )
    }

    static var kif: Package {
        .remote(
            url: "https://github.com/kif-framework/KIF",
            requirement: .upToNextMajor(from: "3.8.0")
        )
    }
}

public extension Array where Element == Package {
    static var testPackages: [Package] {
        [.cuckoo, .kif]
    }
}
