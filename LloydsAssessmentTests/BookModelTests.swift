//
//  BookModelTests.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 01/10/24.
//

import XCTest
@testable import LloydsAssessment

class BookModelTests: XCTestCase {
    func testBookDecoding() {
        let jsonData = """
        {
            "id": 1,
            "title": "Sample Book",
            "author": "Author Name",
            "publication_year": 2024,
            "genre": ["Fiction"],
            "description": "This is a sample book.",
            "cover_image": "https://fastly.picsum.photos/id/830/200/300.jpg"
        }
        """.data(using: .utf8)!
        
        do {
            let book = try JSONDecoder().decode(Book.self, from: jsonData)
            XCTAssertEqual(book.id, 1)
            XCTAssertEqual(book.title, "Sample Book")
            XCTAssertEqual(book.author, "Author Name")
            XCTAssertEqual(book.publicationYear, 2024)
            XCTAssertEqual(book.genre, ["Fiction"])
            XCTAssertEqual(book.description, "This is a sample book.")
            XCTAssertEqual(book.coverImage, "https://fastly.picsum.photos/id/830/200/300.jpg")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
