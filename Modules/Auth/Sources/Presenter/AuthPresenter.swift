//
// AuthPresenter.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation

public protocol AuthPresenterProtocol {
    func register(email: String, password: String)
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

    public func register(email: String, password: String) {
        view?.showLoading()

//        Task {
//            do {
//                try await authUseCase.register(email: email, password: password)
//                await MainActor.run { [weak self] in
//                    self?.view?.hideLoading()
//                    self?.view?.showSuccess()
//                }
//            } catch {
//                await MainActor.run { [weak self] in
//                    self?.view?.hideLoading()
//                    self?.view?.showError(error.localizedDescription)
//                }
//            }
//        }
    }
}
