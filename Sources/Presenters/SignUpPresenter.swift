//
// SignUpPresenter.swift
// Sleep-Tracker
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation
import Auth
import Shared


public protocol SignUpPresenterProtocol {
    func register(name: String, email: String, password: String)
}

public final class SignUpPresenter: SignUpPresenterProtocol {
    
    private let authUseCase: AuthUseCaseProtocol
    private let networkMonitor: ConnectivityServiceProtocol
    weak var view: SignUpViewProtocol?
    
    public init(
        authUseCase: AuthUseCaseProtocol,
        networkMonitor: ConnectivityServiceProtocol
    ) {
        self.authUseCase = authUseCase
        self.networkMonitor = networkMonitor
    }
    
    public func register(name: String, email: String, password: String) {
        
        guard networkMonitor.isConnected else {
            print("No internet connection")
            // TODO: handle no connection
            return
        }
        
        view?.showLoading()
        
        Task {
            do {
                try await authUseCase.register(name: name, email: email, password: password)
                await MainActor.run { [weak self] in
                    self?.view?.hideLoading()
                    self?.view?.showSuccess()
                }
            } catch let error as SignUpError {
                await MainActor.run { [weak self] in
                    self?.view?.hideLoading()
                    
                    let errorDescription: String
                    switch error {
                    case .weakPassword:
                        errorDescription = "User password is too weak"
                        print(errorDescription)
                    case .operationNotAllowed:
                        errorDescription = "Sing up operation is not allowed"
                        print(errorDescription)
                    case .expiredActionCode:
                        errorDescription = "Action code is expired"
                        print(errorDescription)
                    case .invalidActionCode:
                        errorDescription = "Action code is invalid"
                        print(errorDescription)
                    case .failToStoreUserName(let error):
                        errorDescription = "\(error)"
                        print(errorDescription)
                    case .emailValidationFailed(let error):
                        errorDescription = error
                        print(errorDescription)
                    case .emptyUID(let error):
                        errorDescription = error
                        print(errorDescription)
                    case .unknown(let error):
                        errorDescription = error.localizedDescription
                    }
                    self?.view?.showError(errorDescription)
                }
            }
        }
    }
}
