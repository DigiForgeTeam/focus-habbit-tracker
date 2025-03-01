import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "HabbitsTracker",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.HabbitsTracker",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [],
            dependencies: []
        )
    ]
)
