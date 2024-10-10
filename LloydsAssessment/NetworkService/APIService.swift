//
//  APIService.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation
import Combine

class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    //MARK: Generic method to fetch data from an API
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.completeOnMain(.failure(.requestFailed(error)), completion)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                self.completeOnMain(.failure(.invalidResponse(httpResponse.statusCode)), completion)
                return
            }
            
            guard let data = data else {
                self.completeOnMain(.failure(.dataNotFound), completion)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    self.completeOnMain(.success(result), completion)
                } catch {
                    self.completeOnMain(.failure(.decodingFailed(error)), completion)
                }
            }
        }.resume()
    }
    
    private func completeOnMain<T>(_ result: Result<T, APIError>, _ completion: @escaping (Result<T, APIError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
