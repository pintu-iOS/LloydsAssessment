//
//  BooksListView.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import SwiftUI

struct BooksListView: View {
    @ObservedObject var bookViewModel: BookViewModel
    
    var body: some View {
        List(bookViewModel.books) { book in
            BookListRowView(book: book)
                .onAppear {
                    bookViewModel.loadMoreBooksIfNeeded(currentBook: book)
                }
        }
        .navigationTitle(Constant.dashboardTitle)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                bookViewModel.fetchBooks()
            }
        }
        .alert(item: $bookViewModel.errorMessage) { error in
            Alert(title: Text(Constant.error),
                  message: Text(error.message),
                  dismissButton: .default(Text(Constant.ok)))
        }
        .overlay {
            if bookViewModel.isLoading {
                ProgressView(Constant.loading)
            }
        }
    }
}


struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView(bookViewModel: BookViewModel())
    }
}
