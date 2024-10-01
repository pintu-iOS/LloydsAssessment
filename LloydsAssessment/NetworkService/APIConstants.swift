//
//  APIConstants.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://freetestapi.com/api/v1"
    
    //API endpoints
    enum Endpoint {
        case books(page: Int, limit: Int)
        
        var url: URL? {
            switch self {
            case .books(let page, let limit):
                return URL(string: "\(APIConstants.baseURL)/books?limit=\(limit)&page=\(page)")
            }
        }
    }
}
