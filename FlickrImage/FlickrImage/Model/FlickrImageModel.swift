//
//  FlickrImageModel.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import Foundation
import Combine


struct FlickrImageModel: Codable {
    let items: [FlickrItem]
}

struct FlickrItem: Codable, Identifiable {
    var id: String { link }
    let title: String
    let media: Media
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let tags: String
    let link: String
}

struct Media: Codable {
    let m: String 
}

protocol FlickrServiceProtocol {
    func fetchImages(for tags: String) -> AnyPublisher<[FlickrItem], Error>
}
