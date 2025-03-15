//
// ConnectivityService.swift
// Shared
//
// Created by Dmitriy Mk on 15.03.25.
//

import Foundation
import Network


public protocol ConnectivityServiceProtocol {
    var isConnected: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}

public final class NetworkMonitor: ConnectivityServiceProtocol {
        
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published public private(set) var isConnected: Bool = false
    
    public init() {
        startMonitoring()
    }
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
