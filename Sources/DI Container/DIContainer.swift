//
// ConnectivityService.swift
// Shared
//
// Created by Dmitriy Mk on 15.03.25.
//

import Foundation
import Swinject
import Auth
import Shared
import PersistanceManager


final class DIContainer {

    public static let shared = DIContainer()
    private let container = Container()

    private init() {
        self.registerServices()
    }

    private func registerServices() {
        self.registrateAuthService()
        self.registratePersistanceManager()
        self.registrateUserDataManager()
        self.registrateAuthUseCase()
        self.registrateNetworkingMonitor()
        self.registrateSignUpViewController()
        self.registrateSignUpPresenter()
    }

    private func registrateAuthService() {
        container.register(AuthServiceProtocol.self) { _ in
            return AuthService()
        }.inObjectScope(.container)
    }
    
    private func registratePersistanceManager() {
        container.register(PersistanceManagerProtocol.self) { _ in
            return CoreDataManager()
        }.inObjectScope(.container)
    }
    
    private func registrateUserDataManager() {
        container.register(UserDataManagerProtocol.self) { resolver in
            guard let persistanceManager = resolver.resolve(PersistanceManagerProtocol.self) else {
                fatalError()
            }
            return UserDataManager(persistanceManager: persistanceManager)
        }.inObjectScope(.container)
    }

    private func registrateAuthUseCase() {
        container.register(AuthUseCaseProtocol.self) { resolver in
            guard
                let authService = resolver.resolve(AuthServiceProtocol.self) as? AuthService,
                let userDataManager = resolver.resolve(UserDataManagerProtocol.self)
            else {
                fatalError()
            }
            return AuthUseCase(authService: authService,
                               userDataManager: userDataManager)
        }.inObjectScope(.container)
    }
    
    private func registrateNetworkingMonitor() {
        container.register(ConnectivityServiceProtocol.self) { resolver in
            return NetworkMonitor()
        }.inObjectScope(.container)
    }
    
    private func registrateSignUpViewController() {
        container.register(SignUpViewProtocol.self) { resolver in
            let authPresenter = resolver.resolve(SignUpPresenterProtocol.self)!
            return SignUpViewController(presenter: authPresenter)
        }
    }

    private func registrateSignUpPresenter() {
        container.register(SignUpPresenterProtocol.self) { resolver in
            let authUseCase = resolver.resolve(AuthUseCaseProtocol.self)!
            let connectivityMonitor = resolver.resolve(ConnectivityServiceProtocol.self)!
            return SignUpPresenter(
                authUseCase: authUseCase,
                networkMonitor: connectivityMonitor
            )
        }
        .initCompleted { resolver, presenter in
            if let presenter = presenter as? SignUpPresenter,
               let view = resolver.resolve(SignUpViewProtocol.self) {
                presenter.view = view
            }
        }
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}
