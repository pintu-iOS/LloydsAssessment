//
//  BookModelTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment

class BookModelTests: XCTestCase {
    
    //MARK: Test case for book model decodable
    func testBookCodable() {
        let json = TestCaseConstant.testJson.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let book = try? decoder.decode(Book.self, from: json)
        
        XCTAssertNotNil(book)
        XCTAssertEqual(book?.title, TestCaseConstant.testJsonTitle)
        XCTAssertEqual(book?.author, TestCaseConstant.testJsonAuthor)
        XCTAssertEqual(book?.id, TestCaseConstant.testJsonId)
        XCTAssertEqual(book?.genre, TestCaseConstant.testJsonGenre)
        XCTAssertEqual(book?.yearPublished, TestCaseConstant.testJsonYearPublished)
        XCTAssertEqual(book?.checkedOut, true)
        XCTAssertEqual(book?.createdAt, TestCaseConstant.testJsonCreatedAt)
    }
}
