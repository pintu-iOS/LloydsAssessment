//
//  Book.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

//Book model
struct Book: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let author: String
    let publicationYear: Int
    let genre: [String]
    let description: String
    let coverImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case publicationYear = "publication_year"
        case genre
        case description
        case coverImage = "cover_image"
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}
