//
// UserDataManagerProtocols.swift
// PersistanceManager
//
// Created by Dmitriy Mk on 17.03.25.
//


import CoreData


public protocol UserDataManagerProtocol {
    func createUser(with info: [String: Any])
    func updateUser(_ info: [String: Any], for uid: String)
    func getUser(with uid: String) -> UserEntity?
    func getUsers() -> [UserEntity]
    func removeUser(with uid: String)
}
