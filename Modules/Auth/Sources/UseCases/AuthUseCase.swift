//
// AuthUseCase.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation
import FirebaseAuth
import PersistanceManager


public protocol AuthUseCaseProtocol {
    func register(name: String, email: String, password: String) async throws
}

public final class AuthUseCase: AuthUseCaseProtocol {

    private let authService: AuthServiceProtocol
    private let userDataManager: UserDataManagerProtocol

    public init(authService: AuthServiceProtocol, userDataManager: UserDataManagerProtocol) {
        self.authService = authService
        self.userDataManager = userDataManager
    }

    // MARK: - Busines logic
    
    public func isUserLoggedIn() -> Bool {
        authService.isUserSignedIn()
    }

    public func register(name: String, email: String, password: String) async throws {
        
        do {
            let signUpResult = try await authService.registerUser(email: email, password: password)
            let userData = UserModel(
                uid: signUpResult.user.uid,
                name: name,
                email: signUpResult.user.email ?? ""
            )
            
            // MARK: Send email validation code
            do {
                try await Auth.auth().currentUser?.sendEmailVerification()
            } catch {
                throw SignUpError.emailValidationFailed("Failed to send email verification code: \(error.localizedDescription)")
            }
            
            // MARK: Persiste user data to CoreData
            if let userModelDictionary = userData.asDictionary() {
                userDataManager.createUser(with: userModelDictionary)
            }

            // Цикл для повторных попыток сохраниния данных пользователя
            
            guard !userData.uid.isEmpty else {
                throw SignUpError.emptyUID("Invalid UID: UID is empty")
            }
            
            let maxAttempts = 3
            var attempts = 0
            var lastError: Error?

            while attempts < maxAttempts {
                do {
                    
                    // MARK: Persiste username to Firestore
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
    }
}
