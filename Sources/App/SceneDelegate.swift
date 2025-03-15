import UIKit
import Auth
import Swinject
import Shared


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var printAVC: String?
    private var connectivityService: ConnectivityServiceProtocol? {
        DIContainer.shared.resolve(ConnectivityServiceProtocol.self)
    }

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let signUpVC = DIContainer.shared.resolve(SignUpViewProtocol.self) as? SignUpViewController
        guard let rootVC = signUpVC else {
            fatalError("❌ DIContainer не смог разрешить SignUpViewController")
        }

        window = UIWindow(windowScene: windowScene)
        window!.rootViewController = rootVC
        window!.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        connectivityService?.stopMonitoring()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        connectivityService?.startMonitoring()
    }
}
