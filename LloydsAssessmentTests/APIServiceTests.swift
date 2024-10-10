//
//  APIServiceTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment 

class APIServiceTests: XCTestCase {
    
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        apiService = APIService.shared
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    //MARK: Test case for Fetch Data with Successful Response
    func testFetchDataSuccessfulResponse() {
        let expectation = self.expectation(description: TestCaseConstant.testExpectionDescription)
        
        guard let url = APIConstants.Endpoint.books.url else {
            XCTFail(TestCaseConstant.testEmptyUrlMessage)
            return
        }
        
        apiService.fetchData(from: url) { (result: Result<[Book], APIError>) in
            switch result {
            case .success(let books):
                XCTAssertFalse(books.isEmpty, TestCaseConstant.testBooksShouldBeLoadedOnlineMsg)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(TestCaseConstant.testApiFailedWithError) \(error)")
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //MARK: Test case for Fetch Data with Failure Response
    func testFetchDataFailureResponse() {
        let expectation = self.expectation(description: TestCaseConstant.testExpectionDescription)
        
        guard let url = URL(string: TestCaseConstant.testWrongUrlString) else {
            XCTFail(TestCaseConstant.testEmptyUrlMessage)
            return
        }
        
        apiService.fetchData(from: url) { (result: Result<[Book], APIError>) in
            switch result {
            case .success:
                XCTFail(TestCaseConstant.testExpectedFailureButGotSuccessMsg)
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
