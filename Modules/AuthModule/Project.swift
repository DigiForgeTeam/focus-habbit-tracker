import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "AuthModule",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.yourdomain.AuthModule",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            dependencies: []
        )
    ]
)
