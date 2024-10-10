# LloydsAssessment
A SwiftUI-based iOS application that displays a list of books using data fetched from an API. The app is built with performance, scalability, maintainability, and testability in mind, featuring a clean architecture with an MVVM pattern, API service, and UI test cases.

# Features
-> Display a list of books with details like title, author, and publication year.

-> Support for lazy loading with pagination (loading more books when the user scrolls).

-> Loading indicators for a better user experience.

-> Error handling with user-friendly alerts.

-> Unit tests for view models and network requests.

-> UI tests to verify the functionality of views.

# Technologies Used
-> Swift 5

-> SwiftUI

-> Combine

-> MVVM architecture

-> URLSession for networking

-> Codable for JSON decoding

-> ViewInspector for UI testing

-> XCTest for unit testing

# Architecture
This project follows the MVVM (Model-View-ViewModel) architecture pattern. The responsibilities are split as follows:

**Model**: Defines the Book structure and the API error types.

**View**: The SwiftUI views (e.g., BooksListView, BookListRowView) handle the presentation layer and user interactions.

**ViewModel**: (BookViewModel) manages the business logic, state, and interacts with the APIService to fetch data.

**Service**: (APIService) is responsible for making network requests to fetch the book data from the API.

<img width="236" alt="Screenshot 2024-10-10 at 7 37 47 AM" src="https://github.com/user-attachments/assets/97d61d08-e275-4480-9dc8-87f95f3b25f5">

# API
The app fetches book data from a free book API. The base URL used in the project is:

-> https://postman-library-api.glitch.me/books

The API returns book details including id, title, author, publication year, genre, checkedOut, and createdAt.

# Unit Testing
Unit tests have been written for the following components:

**APIServiceTests.swift:** This file contains unit tests for the APIService class, validating the data fetching logic and error handling when interacting with the API.

**BookModelTests.swift:** This file tests the Book model, ensuring that the properties and methods function correctly and that the model conforms to the expected protocols.

**BookViewModelTests.swift:** This tests the logic for fetching books and managing the book list, including scenarios for online and offline states, as well as loading more books as needed.
