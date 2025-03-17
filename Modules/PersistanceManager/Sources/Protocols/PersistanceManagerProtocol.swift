//
// PersistanceManagerProtocol.swift
// PersistanceManager
//
// Created by Dmitriy Mk on 17.03.25.
//

import CoreData


public protocol PersistanceManagerProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
}
