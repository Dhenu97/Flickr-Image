//
//  FlickrImageViewModelTests.swift
//  FlickrImageTests
//
//  Created by dhenu on 4/24/25.
//

import XCTest
import Combine
@testable import FlickrImage

class MockFlickrService: FlickrServiceProtocol {
    func fetchImages(for tags: String) -> AnyPublisher<[FlickrItem], Error> {
        let mockItem = FlickrItem(
            title: "Mock Title",
            media: Media(m: "https://mock.url/image.jpg"),
            date_taken: "2023-01-01T12:00:00Z",
            description: "Mock Description",
            published: "2023-01-02T12:00:00Z",
            author: "Mock Author",
            tags: "mock,photo",
            link: "https://mock.url"
        )
        return Just([mockItem])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class FlickrImageViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testImageFetchFromMockService() {
        let mockService = MockFlickrService()
        let viewModel = FlickrImageViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Fetch mock image")

        viewModel.$images
            .dropFirst()
            .sink { images in
                XCTAssertEqual(images.count, 1)
                XCTAssertEqual(images.first?.title, "Mock Title")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "mock"

        wait(for: [expectation], timeout: 2.0)
    }


}
