import UIKit
import Auth


public protocol SignUpViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showSuccess()
    func showError(_ message: String)
}

final class SignUpViewController: UIViewController, SignUpViewProtocol {

    private let presenter: SignUpPresenterProtocol

    init(presenter: SignUpPresenterProtocol) {
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
        let name = "John"
        let email = "test@example.com"
        let password = "password123"
        presenter.register(name: name, email: email, password: password)
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
