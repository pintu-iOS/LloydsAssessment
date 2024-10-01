//
//  NetworkMonitor.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 01/10/24.
//

import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private let monitor: NWPathMonitor
    private var queue: DispatchQueue
    @Published var isConnected: Bool = false

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "Monitor")
        startMonitoring()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
