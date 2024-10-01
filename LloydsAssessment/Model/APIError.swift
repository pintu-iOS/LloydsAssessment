//
//  APIError.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse(Int)  
    case dataNotFound
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let error):
            return "The request failed with error: \(error.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "Received invalid response with status code: \(statusCode)"
        case .dataNotFound:
            return "No data was returned by the server."
        case .decodingFailed(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}
