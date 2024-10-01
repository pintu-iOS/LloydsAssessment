//
//  ContentView.swift
//  LloydsAssessment
//
//  Created by Pintu Kumar on 30/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            BooksListView(bookViewModel: BookViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
