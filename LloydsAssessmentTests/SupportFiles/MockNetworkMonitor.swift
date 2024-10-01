//
//  MockNetworkMonitor.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

@testable import LloydsAssessment

class MockNetworkMonitor: NetworkMonitor {
    override var isConnected: Bool {
        get { return self._isConnected }
        set { self._isConnected = newValue }
    }
    
    private var _isConnected = true
}
