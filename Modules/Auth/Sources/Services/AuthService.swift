//
// AuthService.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import FirebaseAuth
import FirebaseModule


public final class AuthService: AuthServiceProtocol {
    
    private let networkManager: NetworkServiceProtocol
    private let storeService: FirestoreServiceProtocol
    
    public init(networkManager: NetworkServiceProtocol = FirebaseManager.shared,
                storeService: FirestoreServiceProtocol = FirestoreService.shared) {
        self.networkManager = networkManager
        self.storeService = storeService
    }
    
    public func registerUser(email: String, password: String) async throws -> AuthDataResult {
        return try await networkManager.registerUser(email: email, password: password)
    }
    
    public func persistUserName(_ name: String, with uid: String) async throws {
        try await storeService.saveUserName(name, uid: uid)
    }
    
    public func isUserSignedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
