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
        
        authUseCase.register(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoading()
                switch result {
                case .success:
                    self?.view?.showSuccess()
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}
