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
    
    private let networkManager: NetworkServiceProtocol
    
    public init(networkManager: NetworkServiceProtocol = FirebaseManager.shared) {
        self.networkManager = networkManager
    }
    
    public func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await networkManager.registerUser(email: email, password: password)
    }
}
