//
// AuthPresenter.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation

public protocol AuthPresenterProtocol {
    func register(name: String, email: String, password: String)
}

public protocol AuthViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showSuccess()
    func showError(_ message: String)
}

public final class AuthPresenter: AuthPresenterProtocol {
    private let authUseCase: AuthUseCaseProtocol
    private weak var view: AuthViewProtocol?

    public init(authUseCase: AuthUseCaseProtocol, view: AuthViewProtocol) {
        self.authUseCase = authUseCase
        self.view = view
    }

    public func register(name: String, email: String, password: String) {
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
                    case .unknown(let error):
                        errorDescription = error.localizedDescription
                    }
                    self?.view?.showError(errorDescription)
                }
            }
        }
    }
}
