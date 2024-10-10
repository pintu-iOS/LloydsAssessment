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

    //MARK: Network Monitor Initialization
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: DispatchQueueLabel.monitorDispatchLabel)
        startMonitoring()
    }

    //MARK: Monitoring internet connections
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }

    //MARK: Deinit function is using here to cancel internet monitoring
    deinit {
        monitor.cancel()
    }
}
