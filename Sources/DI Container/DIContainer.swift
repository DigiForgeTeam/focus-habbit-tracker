import Foundation
import Swinject
import Auth

final class DIContainer {

    public static let shared = DIContainer()
    private let container = Container()

    private init() {
        self.registerServices()
    }

    private func registerServices() {
        self.registrateAuthService()
        self.registrateAuthPresenter()
        self.registrateAuthUseCase()
        self.registrateAuthView()
    }

    private func registrateAuthService() {
        container.register(AuthServiceProtocol.self) { _ in
            return AuthService()
        }
    }

    private func registrateAuthUseCase() {
        container.register(AuthUseCaseProtocol.self) { resolver in
            guard let authService = resolver.resolve(AuthServiceProtocol.self) as? AuthService else {
                fatalError()
            }
            return AuthUseCase(authService: authService)
        }
    }

    private func registrateAuthView() {
        container.register(SignUpViewController.self) { resolver in
            let authPresenter = resolver.resolve(SignUpPresenterProtocol.self)!
            return SignUpViewController(presenter: authPresenter)
        }
    }

    private func registrateAuthPresenter() {
        container.register(SignUpPresenterProtocol.self) { resolver in
            let authUseCase = resolver.resolve(AuthUseCaseProtocol.self)!
            let view = resolver.resolve(SignUpViewController.self)!
            return SignUpPresenter(authUseCase: authUseCase, view: view)
        }
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}
