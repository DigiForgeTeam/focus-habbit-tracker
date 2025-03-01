import ProjectDescription

let projectName = "Focus-Habit-Tracker"
let bundleID = "com.yourcompany.FocusHabitTracker"
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
            resources: ["\(basePath)/Resources/**"],
            dependencies: [
                .project(
                    target: "AuthModule",
                    path: "Modules/AuthModule"
                ),
                .project(
                    target: "WelcomeModule",
                    path: "Modules/WelcomeModule"
                ),
                .project(
                    target: "HabbitsTracker",
                    path: "Modules/HabbitsTracker"
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
        ),
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

