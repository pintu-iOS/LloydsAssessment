//
//  BookListRowView.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 01/10/24.
//

import SwiftUI

struct BookListRowView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            Text(Constant.author + book.author)
                .font(.subheadline)
            Text(Constant.published + String(book.yearPublished))
                .font(.subheadline)
        }
    }
}
