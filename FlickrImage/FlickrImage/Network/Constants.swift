//
//  Constants.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
        static let format = "json"
        static let noJSONCallback = "1"
    }
}

struct FlickrAPI {
    static func buildURL(for tags: String) -> URL? {
        var components = URLComponents(string: Constants.API.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "format", value: Constants.API.format),
            URLQueryItem(name: "nojsoncallback", value: Constants.API.noJSONCallback),
            URLQueryItem(name: "tags", value: tags)
        ]
        return components?.url
    }
}
