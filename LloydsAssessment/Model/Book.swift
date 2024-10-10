//
//  Book.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

//MARK: Books Model
struct Book: Identifiable, Codable, Equatable {
    let title, author, id, genre: String
    let yearPublished: Int
    let checkedOut: Bool
    let createdAt: String
}
