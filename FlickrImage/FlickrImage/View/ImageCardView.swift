//
//  ImageCardView.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import SwiftUI

struct ImageCardView: View {
    let item: FlickrItem

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: item.media.m)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: 150)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: geometry.size.width, height: 150)
            }
        }
        .frame(height: 150) 
    }
}

