//
//  APIServiceTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment 

class APIServiceTests: XCTestCase {
    var mockSession: MockURLSession!
    var apiService: APIService!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        apiService = APIService(testingSession: mockSession)
    }

    override func tearDown() {
        mockSession = nil
        apiService = nil
        super.tearDown()
    }

    func testFetchDataSuccess() {
        let expectedBookData = """
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

        mockSession.dataTaskResult = (expectedBookData, nil, nil)

        let expectation = self.expectation(description: "Fetch data success")

        apiService.fetchData(from: URL(string: "https://freetestapi.com/api/v1/books")!) { (result: Result<[Book], APIError>) in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 1)
                XCTAssertEqual(books[0].title, "Sample Book")
            case .failure:
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchDataFailure() {
        mockSession.dataTaskResult = (nil, nil, NSError(domain: "TestError", code: 1, userInfo: nil))

        let expectation = self.expectation(description: "Fetch data failure")

        apiService.fetchData(from: URL(string: "https://freetestapi.com/api/v1/books")!) { (result: Result<[Book], APIError>) in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
