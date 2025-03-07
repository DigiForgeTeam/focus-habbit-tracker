import Foundation

public protocol AuthUseCaseProtocol {
    func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

public final class AuthUseCase: AuthUseCaseProtocol {
    private let authService: AuthService

    public init(authService: AuthService) {
        self.authService = authService
    }

    public func register(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.registerUser(email: email, password: password, completion: completion)
        
        //TODO: К примеру тут делаем валидацию по почте, после успешной регистрации пользователя
    }
}
