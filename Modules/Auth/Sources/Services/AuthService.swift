//
// AuthService.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import FirebaseAuth
import FirebaseModule

public protocol AuthServiceProtocol {
    func registerUser(email: String, password: String) async throws -> AuthDataResult
}

public final class AuthService: AuthServiceProtocol {
    
    public init() { }
    
    public func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await FirebaseManager.shared.registerUser(email: email, password: password)
    }
}
