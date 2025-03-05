import ProjectDescription

let projectName = "Focus-Habit-Tracker"

let project = Project(
    name: projectName,
    organizationName: "com.digicom",
    targets: [
        .target(
            name: "HabitsTracker",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.HabitsTracker",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [
                //         "Scripts/**",
                ".swiftlint.yml",
            ],
            scripts: [
                .pre(
//                    path: .relativeToRoot(
//                        "Scripts/SwiftLintRunScript.sh"
//                    ),
                    script: """
#!/bin/bash
if [[ "$(uname -m)" == arm64 ]]
then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if command -v swiftlint >/dev/null 2>&1
then
echo "Config file path: ${PROJECT_DIR}/.swiftlint.yml"
#  swiftlint --config "${PROJECT_DIR}/.swiftlint.yml" --strict
swiftlint --strict
else
    echo "warning: `swiftlint` command not found - See https://github.com/realm/SwiftLint#installation for installation instructions."
fi


""",
                    name: "SwiftLint",
                    outputPaths: ["${PROJECT_DIR}/swiftlint_output.log"],
                    basedOnDependencyAnalysis: true
                )
            ],
            dependencies: []
        )
    ]
)
