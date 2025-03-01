import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "UserProfile",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.UserProfile",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [],
            dependencies: []
        )
    ]
)
