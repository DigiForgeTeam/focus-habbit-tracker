//
// AuthUseCase.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation
import FirebaseAuth


public protocol AuthUseCaseProtocol {
    func register(name: String, email: String, password: String) async throws
}

public final class AuthUseCase: AuthUseCaseProtocol {

    private let authService: AuthServiceProtocol

    public init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    public func register(name: String, email: String, password: String) async throws {
        
        do {
            let signUpResult = try await authService.registerUser(email: email, password: password)
            let userData = UserModel(
                uid: signUpResult.user.uid,
                name: name,
                email: signUpResult.user.email ?? ""
            )

            // Цикл для повторных попыток сохраниния данных пользователя
            
            guard !userData.uid.isEmpty else {
                throw SignUpError.emptyUID("Invalid UID: UID is empty")
            }
            
            let maxAttempts = 3
            var attempts = 0
            var lastError: Error?

            while attempts < maxAttempts {
                do {
                    try await authService.persistUserName(name, with: userData.uid)
                    print("Имя пользователя успешно сохранено с попытки \(attempts + 1)")
                    lastError = nil
                    break
                } catch {
                    attempts += 1
                    lastError = error
                    print("Попытка \(attempts) сохранить имя пользователя завершилась ошибкой: \(error.localizedDescription)")

                    if attempts < maxAttempts {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    }
                }
            }

            if let error = lastError {
                throw SignUpError.failToStoreUserName(error.localizedDescription)
            }
            
#warning("Persist username to CoreData Manager")
            
        } catch {
            if let signUpError = error as? SignUpError {
                throw signUpError
            }
            let nsError = error as NSError
            switch nsError.code {
            case AuthErrorCode.weakPassword.rawValue:
                throw SignUpError.weakPassword
            case AuthErrorCode.operationNotAllowed.rawValue:
                throw SignUpError.operationNotAllowed
            case AuthErrorCode.expiredActionCode.rawValue:
                throw SignUpError.expiredActionCode
            case AuthErrorCode.invalidActionCode.rawValue:
                throw SignUpError.invalidActionCode
            default:
                throw SignUpError.unknown(nsError)
            }
        }

        //TODO: К примеру тут делаем валидацию по почте, после успешной регистрации пользователя
    }
}
