//
//  MockURLSession.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment

class MockURLSession: URLSessionProtocol {
    var dataTaskResult: (Data?, URLResponse?, Error?)?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let (data, response, error) = dataTaskResult ?? (nil, nil, nil)
        completionHandler(data, response, error)
        return URLSession.shared.dataTask(with: URL(string: "about:blank")!)
    }
    
}
