//
//  APIConstants.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

struct APIConstants {
    //MARK: Base Url
    static let baseURL = "https://postman-library-api.glitch.me"

    //API endpoints
    enum Endpoint {
        case books
        
        var url: URL? {
            switch self {
            case .books:
                return URL(string: "\(APIConstants.baseURL)/books")
            }
        }
    }
}
