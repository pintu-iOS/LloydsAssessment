//
//  IdentifiableError.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import Foundation

//MARK: Identifiable Error Model
struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}
