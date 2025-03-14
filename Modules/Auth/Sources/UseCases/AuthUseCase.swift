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
            let userData = User(
                uid: signUpResult.user.uid,
                name: name,
                email: signUpResult.user.email,
                photoURL: signUpResult.user.photoURL?.absoluteString
            )
            
            // persiste userData on Firestore and CoreData (to SignIn registered User without connection to network)
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.weakPassword.rawValue:
                throw SignUpError.weakPassword
            case AuthErrorCode.operationNotAllowed.rawValue:
                throw SignUpError.operationNotAllowed
            case AuthErrorCode.expiredActionCode.rawValue:
                throw SignUpError.expiredActionCode
            case AuthErrorCode.invalidActionCode.rawValue:
                throw SignUpError.invalidActionCode
            default:
                throw SignUpError.unknown(error)
            }
        }
        
        //TODO: К примеру тут делаем валидацию по почте, после успешной регистрации пользователя
    }
}
