import ProjectDescription

let projectName = "Sleep-Tracker"
let bundleID = "com.digicom.SleepTracker"
let iOSTargetVersion = "15.0"
let basePath = "."
private let bundleVersion: String = "1"
private let version: String = "0.0.1"

let project = Project(
    name: projectName,
    organizationName: "DigiCom",
    targets: [
        .target(
            name: projectName,
            destinations: [.iPhone, .iPad],
            product: .app,
            bundleId: bundleID,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: makeInfoPlist(),
            sources: ["Sources/**/*.swift"],
            resources: [
                "\(basePath)/Resources/**",
                "\(basePath)/.swiftlint.yml",
            ],
            scripts: [
                .pre(
                    path: .relativeToRoot(
                        "Scripts/SwiftLintRunScript.sh"
                    ),
                    name: "SwiftLint",
                    outputPaths: ["${PROJECT_DIR}/swiftlint_output.log"],
                    basedOnDependencyAnalysis: true
                )
            ],
            dependencies: [
                .project(
                    target: "Auth",
                    path: "Modules/Auth"
                ),
                .project(
                    target: "Questionnaire",
                    path: "Modules/Questionnaire"
                ),
                .project(
                    target: "Report",
                    path: "Modules/Report"
                ),
                .project(
                    target: "Shared",
                    path: "Modules/Shared"
                ),
                .project(
                    target: "SleepTracker",
                    path: "Modules/SleepTracker"
                ),
                .project(
                    target: "UserProfile",
                    path: "Modules/UserProfile"
                )
            ]
        ),
        .target(
            name: "\(projectName)Tests",
            destinations: [.iPhone, .iPad],
            product: .unitTests,
            bundleId: "\(bundleID).tests",
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: .default,
            sources: ["\(basePath)/Tests/**"],
            dependencies: [
                .target(name: projectName)
            ]
        )
    ]
)

private func makeConfigurations() -> [Configuration] {
    let debug: Configuration = .debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig")
    let release: Configuration = .release(name: "Release", xcconfig: "Configs/Release.xcconfig")
    
    return [debug, release]
}

private func baseSettings() -> Settings {
    let settings = SettingsDictionary()
    return Settings.settings(
        base: settings,
        configurations: makeConfigurations(),
        defaultSettings: .recommended
    )
}

private func makeInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: Plist.Value] = [
        "UIApplicationSceneManifest": .dictionary([
            "UIApplicationSupportsMultipleScenes": .boolean(false),
            "UISceneConfigurations": .dictionary([
                "UIWindowSceneSessionRoleApplication": .array([
                    .dictionary([
                        "UISceneConfigurationName": .string("Default Configuration"),
                        "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
                    ])
                ])
            ])
        ]),
        "UILaunchScreen": .dictionary([:]),
        "UISupportedInterfaceOrientations": .array([
            .string("UIInterfaceOrientationPortrait")
        ]),
        "CFBundleShortVersionString": .string(version),
        "CFBundleVersion": .string(bundleVersion),
        "CFBundleDisplayName": .string("$(APP_DISPLAY_NAME)")
    ]
    
    extendedPlist.merge(other) { _, new in new }
    
    return .extendingDefault(with: extendedPlist)
}
