//
//  NewReleaased.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 09.03.2024.
//

import Foundation

// MARK: - Newreleased
struct NewReleased: Decodable {
    let albums: Albums
}

// MARK: - Albums
struct Albums: Decodable {
    let items: [Playlist]
}

// MARK: - Item
struct Playlist: Decodable {
    let id: String?
    let images: [Image]
    let name: String

    enum CodingKeys: String, CodingKey {
        case images, name, id
    }
}

//// MARK: - Artist
//struct Artist: Codable {
//    let externalUrls: ExternalUrls
//    let href, id, name, type: String
//    let uri: String
//
//    enum CodingKeys: String, CodingKey {
//        case externalUrls = "external_urls"
//        case href, id, name, type, uri
//    }
//}

