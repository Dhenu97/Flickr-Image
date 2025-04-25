//
//  ContentView.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlickrImageViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }

                if let error = viewModel.errorMessage {
                    ErrorView(message: error)
                }

                ImageGridView(items: viewModel.images)
            }
            .navigationTitle("Flickr Search")
        }
    }
}

#Preview {
    ContentView()
}



struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search Flickr...", text: $text)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}


struct ErrorView: View {
    let message: String

    var body: some View {
        Text("\(message)")
            .foregroundColor(.red)
            .padding()
    }
}


struct ImageGridView: View {
    let items: [FlickrItem]

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 160), spacing: 12)]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items) { item in
                    NavigationLink(destination: ImageDetailView(item: item)) {
                        ImageCardView(item: item)
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes default NavigationLink styling
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

