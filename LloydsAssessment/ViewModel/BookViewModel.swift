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
    private let networkMonitor: NetworkMonitor
    private var currentPage = 1
    private var canLoadMore = true
    
    init(apiService: APIService = APIService.shared, networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.apiService = apiService
        self.networkMonitor = networkMonitor
        self.networkMonitor.startMonitoring()
    }
    
    //Fetching books list
    func fetchBooks(page: Int = 1, limit: Int = 10) {
        guard networkMonitor.isConnected else {
            self.errorMessage = IdentifiableError(message: Constant.noInternetErrorMessage)
            return
        }
        guard let url = APIConstants.Endpoint.books(page: page, limit: limit).url else {
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
                    if books.isEmpty {
                        self?.canLoadMore = false
                    } else {
                        self?.books.append(contentsOf: books)
                        self?.currentPage += 1
                    }
                }
            }
        }
    }
    
    // Load more books when the user scrolls to near the bottom
    func loadMoreBooksIfNeeded(currentBook: Book) {
        guard let index = books.firstIndex(of: currentBook) else { return }
        // Load more if we are within the last 3 items
        if index >= (books.count - 3) && canLoadMore {
            fetchBooks()
        }
    }
}
