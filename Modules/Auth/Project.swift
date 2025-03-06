import ProjectDescription

let organizationName = "com.digicom"
let moduleName = "Auth"

let project = Project(
    name: moduleName,
    organizationName: organizationName,
    targets: [
        .target(
            name: moduleName,
            destinations: .iOS,
            product: .framework,
            bundleId: "com.digicom.\(moduleName)",
            deploymentTargets: .iOS("15.0"),
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: [
                ".swiftlint.yml"
            ],
            scripts: [
                .pre(
                    script: """
#!/bin/bash
if command -v swiftlint >/dev/null 2>&1
then
echo "Running SwiftLint with config: ${PROJECT_DIR}/.swiftlint.yml"
swiftlint --config "${PROJECT_DIR}/.swiftlint.yml" --strict
else
echo "warning: SwiftLint not found. Please install it via 'brew install swiftlint'."
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
