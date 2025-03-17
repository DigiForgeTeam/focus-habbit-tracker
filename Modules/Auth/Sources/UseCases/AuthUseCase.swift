//
// AuthUseCase.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation
import FirebaseAuth
import PersistanceManager
import OSLog


public protocol AuthUseCaseProtocol {
    func register(name: String, email: String, password: String) async throws
}

public final class AuthUseCase: AuthUseCaseProtocol {

    private let authService: AuthServiceProtocol
    private let userDataManager: UserDataManagerProtocol
    private let logger = Logger(subsystem: "com.yourapp.auth", category: "Auth")

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
            try await sendValidationEmail()
            
            // MARK: Persiste user data to CoreData
            persistUserDataToLocalDataBase(userData)

            // MARK: Цикл для повторных попыток сохраниния данных пользователя
            try await checkUserIDAndPersistToFireStore(userData, name)
            
        } catch {
            throw mapFirebaseAuthError(error)
        }
    }
    
    private func sendValidationEmail() async throws {
        if let currentUser = Auth.auth().currentUser {
            do {
                try await currentUser.reload()
                try await currentUser.sendEmailVerification()
            } catch {
                logger.error("Failed to send email verification code: \(error.localizedDescription)")
                throw SignUpError.emailValidationFailed("Failed to send email verification code: \(error.localizedDescription)")
            }
        }
    }
    
    private func persistUserDataToLocalDataBase(_ userData: UserModel) {
        Task.detached {
            if let userModelDictionary = userData.asDictionary() {
                self.userDataManager.createUser(with: userModelDictionary)
            }
        }
    }
    
    private func checkUserIDAndPersistToFireStore(_ userData: UserModel, _ name: String) async throws {
        guard !userData.uid.isEmpty else {
            logger.error("Invalid UID: UID is empty")
            throw SignUpError.emptyUID("Invalid UID: UID is empty")
        }
        
        try await retry(times: 3, delay: 1) { [ weak self ] in
            try await self?.authService.persistUserName(name, with: userData.uid)
        }
    }
    
    func retry<T>(
        times: Int,
        delay: TimeInterval,
        task: @escaping () async throws -> T
    ) async throws -> T {
        var attempts = 0
        var lastError: Error?
        
        while attempts < times {
            do {
                return try await task()
            } catch {
                lastError = error
                attempts += 1
                if attempts < times {
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                }
            }
        }
        
        let currentError = lastError?.localizedDescription ?? "Unknown error during retry"
        logger.error("Fails \(attempts) to store user name with error: \(currentError)")
        throw SignUpError.failToStoreUserName(currentError)
    }
    
    func mapFirebaseAuthError(_ error: Error) -> SignUpError {
        guard let nsError = error as NSError?,
              let authError = AuthErrorCode(rawValue: nsError.code) else {
            logger.error("Unknown error: \(error.localizedDescription)")
            return .unknown(error)
        }

        switch authError {
        case .weakPassword:
            return .weakPassword
        case .operationNotAllowed:
            return .operationNotAllowed
        case .expiredActionCode:
            return .expiredActionCode
        case .invalidActionCode:
            return .invalidActionCode
        default:
            return .unknown(error)
        }
    }
}
