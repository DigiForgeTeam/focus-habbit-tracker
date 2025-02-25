import ProjectDescription

let project = Project(
    name: "WelcomeModule",
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "WelcomeModule",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.WelcomeModule",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: []
        )
    ]
)
