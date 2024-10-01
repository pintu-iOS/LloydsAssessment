//
//  BookViewModelTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment

class BookViewModelTests: XCTestCase {
    
    var expectedBookData: Data?
    var viewModel: BookViewModel!
    var mockSession: MockURLSession!
    var mockNetworkMonitor: MockNetworkMonitor!
    
    override func setUp() {
        super.setUp()
        expectedBookData = """
    [{
        "id": 1,
        "title": "Sample Book",
        "author": "Author Name",
        "publication_year": 2024,
        "genre": ["Fiction"],
        "description": "This is a sample book.",
        "cover_image": "https://example.com/sample.jpg"
    }]
    """.data(using: .utf8)
        
        mockSession = MockURLSession()
        mockNetworkMonitor = MockNetworkMonitor()
        viewModel = BookViewModel(apiService: APIService(testingSession: mockSession), networkMonitor: mockNetworkMonitor)
    }
    
    override func tearDown() {
        expectedBookData = nil
        viewModel = nil
        mockSession = nil
        mockNetworkMonitor = nil
        super.tearDown()
    }
    
    func testFetchBooksWhenOffline() {
        // Simulate offline state
        mockNetworkMonitor.isConnected = false
        viewModel.fetchBooks()
        XCTAssertEqual(viewModel.errorMessage?.message, Constant.noInternetErrorMessage)
        XCTAssertTrue(viewModel.books.isEmpty)
    }
    
    func testFetchBooksWhenOnline() {
        // Simulate online state
        mockNetworkMonitor.isConnected = true
        mockSession.dataTaskResult = (expectedBookData, nil, nil)
        let expectation = self.expectation(description: "Fetch books success")
        viewModel.fetchBooks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.books.count, 1)
            XCTAssertEqual(self.viewModel.books[0].title, "Sample Book")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchBooksSuccess() {
        mockSession.dataTaskResult = (expectedBookData, nil, nil)
        let expectation = self.expectation(description: "Fetch books success")
        viewModel.fetchBooks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.books.count, 1)
            XCTAssertEqual(self.viewModel.books[0].title, "Sample Book")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchBooksFailure() {
        mockSession.dataTaskResult = (nil, nil, NSError(domain: "TestError", code: 1, userInfo: nil))
        let expectation = self.expectation(description: "Fetch books failure")
        viewModel.fetchBooks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.errorMessage?.message, "The request failed with error: The operation couldn’t be completed. (TestError error 1.)")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadMoreBooks() {
        mockSession.dataTaskResult = (expectedBookData, nil, nil)
        let expectation = self.expectation(description: "Load more books")
        viewModel.fetchBooks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.books.count, 1)
            
            if !self.viewModel.books.isEmpty {
                self.viewModel.loadMoreBooksIfNeeded(currentBook: self.viewModel.books[0])
            }
            
            // Simulate loading more books with new mock data
            let additionalBookData = """
            [{
                "id": 2,
                "title": "Another Sample Book",
                "author": "Another Author",
                "publication_year": 2024,
                "genre": ["Non-Fiction"],
                "description": "This is another sample book.",
                "cover_image": "https://example.com/another.jpg"
            }]
            """.data(using: .utf8)
            
            self.mockSession.dataTaskResult = (additionalBookData, nil, nil)
            
            self.viewModel.fetchBooks()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                XCTAssertEqual(self.viewModel.books.count, 3)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
