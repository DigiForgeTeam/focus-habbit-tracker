import UIKit
import Auth

final class SignUpViewController: UIViewController, AuthViewProtocol {
    private let presenter: AuthPresenterProtocol
    
    init(presenter: AuthPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func signUpButtonTapped() {
        let email = "test@example.com"
        let password = "password123"
        presenter.register(email: email, password: password)
    }

    func showLoading() { }

    func hideLoading() { }

    func showSuccess() {
        print("Регистрация успешна")
    }

    func showError(_ message: String) {
        print("Ошибка регистрации: \(message)")
    }
}
