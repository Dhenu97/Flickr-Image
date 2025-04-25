//
//  FlickrImageViewModel.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import Foundation
import Combine

class FlickrImageViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var images: [FlickrItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let service: FlickrServiceProtocol

  init(service: FlickrServiceProtocol = NetworkService()) {
        self.service = service
        observeSearchText()
    }

    private func observeSearchText() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.searchImages(with: text)
            }
            .store(in: &cancellables)
    }

    private func searchImages(with tags: String) {
        guard !tags.isEmpty else {
            self.images = []
            return
        }
        isLoading = true
        service.fetchImages(for: tags)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] items in
                self?.images = items
            })
            .store(in: &cancellables)
    }
}
