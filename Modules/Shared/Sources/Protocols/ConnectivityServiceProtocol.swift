//
// ConnectivityServiceProtocol.swift
// Shared
//
// Created by Dmitriy Mk on 16.03.25.
//

import Foundation


public protocol ConnectivityServiceProtocol {
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}
