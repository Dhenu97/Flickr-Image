//
//  FlickrImageTests.swift
//  FlickrImageTests
//
//  Created by dhenu on 4/24/25.
//

import XCTest
import Combine
@testable import FlickrImage

final class FlickrImageTests: XCTestCase {

  var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

  func testImageFetchFromMockService() {
      let mockService = MockFlickrService()
      let viewModel = FlickrImageViewModel(service: mockService)
      let expectation = XCTestExpectation(description: "Should fetch 1 mock image")

      viewModel.$images
          .dropFirst()
          .sink { images in
              print("images received: \(images.map { $0.title })")
              XCTAssertEqual(images.count, 1)
              XCTAssertEqual(images.first?.title, "Mock Title")
              expectation.fulfill()
          }
          .store(in: &cancellables)

      print("Setting searchText to 'mock'")
      viewModel.searchText = "mock"

      wait(for: [expectation], timeout: 2.0)
  }

}

