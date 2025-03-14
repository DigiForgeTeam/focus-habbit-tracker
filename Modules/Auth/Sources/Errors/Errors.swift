//
// Errors.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation

/// Ниже указаны возможные ошибки при регистрации на Firebase
/// Possible error codes:
/// * `AuthErrorCodeWeakPassword` - Indicates an attempt to set a password that is
/// considered too weak.
/// * `AuthErrorCodeOperationNotAllowed` - Indicates the administrator disabled sign
/// in with the specified identity provider.
/// * `AuthErrorCodeExpiredActionCode` - Indicates the OOB code is expired.
/// * `AuthErrorCodeInvalidActionCode` - Indicates the OOB code is invalid.
public enum SignUpError: Error {
    case weakPassword
    case operationNotAllowed
    case expiredActionCode
    case invalidActionCode
    case unknown(Error)
    
    public var localizedDescription: String {
        switch self {
        case .weakPassword:
            return "The password is too weak."
        case .operationNotAllowed:
            return "Operation not allowed."
        case .expiredActionCode:
            return "The action code has expired."
        case .invalidActionCode:
            return "The action code is invalid."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
