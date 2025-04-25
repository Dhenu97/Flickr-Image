//
//  WebServices.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import Foundation
import Combine

class NetworkService: FlickrServiceProtocol {
    func fetchImages(for tags: String) -> AnyPublisher<[FlickrItem], Error> {
        // Clean and encode tag string
        let tagString = tags
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: "%2C")

        guard let url = FlickrAPI.buildURL(for: tagString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 10 // Prevent long hangs

        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { output in
                if let jsonString = String(data: output.data, encoding: .utf8) {
                    print("Flickr API Response:\n\(jsonString)")
                }
            })
            .map(\.data)
            .decode(type: FlickrImageModel.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
