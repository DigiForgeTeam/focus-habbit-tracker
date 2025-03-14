//
// AuthModel.swift
// Auth
//
// Created by Dmitriy Mk on 14.03.25.
//

import Foundation

public struct User {
    public let uid: String
    public let name: String
    public let email: String?
    public let photoURL: String?
    
    public init(uid: String, name: String, email: String?, photoURL: String?) {
        self.uid = uid
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
}
