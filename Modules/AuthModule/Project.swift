import ProjectDescription

let project = Project(
    name: "AuthModule",
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "AuthModule",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.AuthModule",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
