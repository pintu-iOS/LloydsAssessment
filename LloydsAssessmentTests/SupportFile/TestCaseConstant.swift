//
//  TestCaseConstant.swift
//  LloydsAssessmentTests
//
//  Created by Pintu Kumar on 09/10/24.
//

import Foundation

struct TestCaseConstant {
    static let testWrongUrlString = "https://postman-library-api.glitch.me/BooksLists"
    
    static let testJson = """
        {
            "title": "The Catcher in the Rye",
            "author": "J.D. Salinger",
            "id": "4",
            "genre": "Fiction",
            "yearPublished": 1951,
            "checkedOut": true,
            "createdAt": "2024-10-09T10:00:00Z"
        }
        """
    
    static let testJsonTitle = "The Catcher in the Rye"
    static let testJsonAuthor = "J.D. Salinger"
    static let testJsonId = "4"
    static let testJsonGenre = "Fiction"
    static let testJsonYearPublished = 1951
    static let testJsonCreatedAt = "2024-10-09T10:00:00Z"
    
    
    static let testExpectionDescription = "API Response Success"
    static let testEmptyUrlMessage = "URL can't be nil"
    static let testApiFailedWithError = "API failed with error:"
    static let testExpectedFailureButGotSuccessMsg = "Expected failure but got success"
    static let testNoInternetConnectionExpectation = "No Internet Connection"
    static let testFetchBookSucceedExpectionDescription = "Fetch books online succeeds"
    static let testBooksShouldBeLoadedOnlineMsg = "Books should be loaded when online."
    static let testErrorMessageShouldBeNilWhenSucceed = "Error message should be nil when fetching succeeds."
    static let testFetchBookFailsExpectionDescription = "Fetch books fails when offline"
    static let testBooksCanNotBeLoadedOnlineMsg = "Books should not be loaded when offline."
    static let testFetchBookSuccess = "Fetch books success"
    static let testFetchBookFailure = "Fetch books failure"
}
