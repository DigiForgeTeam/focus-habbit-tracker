import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "FocusTracker",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.FocusTracker",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [],
            dependencies: []
        )
    ]
)

