//
// AuthServiceProtocol.swift
// Auth
//
// Created by Dmitriy Mk on 17.03.25.
//

import Foundation


public protocol AuthServiceProtocol {
    func registerUser(email: String, password: String) async throws -> AuthDataResult
    func persistUserName(_ name: String, with uid: String) async throws
    func isUserSignedIn() -> Bool
}
