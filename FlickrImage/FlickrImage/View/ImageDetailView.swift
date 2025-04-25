//
//  ImageDetailView.swift
//  FlickrImage
//
//  Created by dhenu on 4/24/25.
//

import SwiftUI

struct ImageDetailView: View {
    let item: FlickrItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: item.media.m)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text("📌 Title: \(item.title)")
                    .font(.headline)

                Text("✍️ Author: \(item.author)")
                    .font(.subheadline)

                Text("📅 Published: \(formattedDate(item.published))")
                    .font(.caption)

                Text("🔗 Link:")
                    .font(.caption)
                    .foregroundColor(.gray)

              if let url = URL(string: item.link) {
                  Link(destination: url) {
                      Text(url.absoluteString)
                          .foregroundColor(.blue)
                          .font(.footnote)
                          .underline()
                          .multilineTextAlignment(.leading)
                  }
              }

                Button(action: shareContent) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Image Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func shareContent() {
        let text = """
        📌 Title: \(item.title)
        ✍️ Author: \(item.author)
        🔗 Link: \(item.link)
        """

        guard let url = URL(string: item.media.m) else { return }

        let activityVC = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }

    private func formattedDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        if let date = formatter.date(from: iso) {
            return displayFormatter.string(from: date)
        }
        return iso
    }
}

