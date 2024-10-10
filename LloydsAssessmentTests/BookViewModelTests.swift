//
//  BookViewModelTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
import Combine
@testable import LloydsAssessment

class BookViewModelTests: XCTestCase {
    var viewModel: BookViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = BookViewModel()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    //MARK: Test case for Fetch Books Data with Successful Response in online internet
    func testFetchBooksWhenOnline() {
        let expectation = XCTestExpectation(description: TestCaseConstant.testFetchBookSucceedExpectionDescription)
        
        // Simulate online state
        viewModel.networkMonitor.isConnected = true
        viewModel.$books
            .sink { books in
                if !books.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Fetch books
        viewModel.fetchBooks()
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertFalse(viewModel.books.isEmpty, TestCaseConstant.testBooksShouldBeLoadedOnlineMsg)
        XCTAssertNil(viewModel.errorMessage, TestCaseConstant.testErrorMessageShouldBeNilWhenSucceed)
    }
    
    //MARK: Test case for Fetch Books Data with Failure Response in offline internet
    func testFetchBooksWhenOffline() {
        let expectation = XCTestExpectation(description: TestCaseConstant.testFetchBookFailsExpectionDescription)
        
        // Simulate network being offline
        viewModel.networkMonitor.isConnected = false
        
        viewModel.$errorMessage
            .sink { errorMessage in
                if errorMessage != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Fetch books
        viewModel.fetchBooks()
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(viewModel.books.isEmpty, TestCaseConstant.testBooksCanNotBeLoadedOnlineMsg)
        XCTAssertEqual(viewModel.errorMessage?.message, Constant.noInternetErrorMessage)
    }
}


