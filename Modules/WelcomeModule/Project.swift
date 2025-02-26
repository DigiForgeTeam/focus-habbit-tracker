import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "WelcomeModule",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.WelcomeModule",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [],
            dependencies: []
        )
    ]
)
