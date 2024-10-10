//
//  BookViewModel.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation
import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError?
    
    private var apiService: APIService!
    let networkMonitor: NetworkMonitor
    
    //MARK: ViewModel Initialization
    init(apiService: APIService = APIService.shared, networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.apiService = apiService
        self.networkMonitor = networkMonitor
        self.networkMonitor.startMonitoring()
    }
    
    //MARK: Fetch books list
    func fetchBooks() {
        guard networkMonitor.isConnected else {
            self.errorMessage = IdentifiableError(message: Constant.noInternetErrorMessage)
            return
        }
        guard let url = APIConstants.Endpoint.books.url else {
            errorMessage = IdentifiableError(message: APIError.invalidURL.errorDescription ?? Constant.invalidUrlErrorMessage)
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        apiService.fetchData(from: url) { (result: Result<[Book], APIError>) in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    self?.errorMessage = IdentifiableError(message: error.errorDescription ?? Constant.unknownErrorMessage)
                case .success(let books):
                    self?.books = books
                }
            }
        }
    }
}
