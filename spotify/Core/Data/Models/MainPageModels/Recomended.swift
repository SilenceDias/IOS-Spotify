//
//  Recomnded.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 13.03.2024.
//

import Foundation

struct Recomended: Decodable {
    let tracks: [Track]
}

// MARK: - Track
struct Track: Decodable {
    let album: Album
    let artists: [Artist]
}

// MARK: - Album
struct Album: Decodable {
    let id: String?
    let images: [Image]?
    let name: String?
}

// MARK: - Artist
struct Artist: Decodable {
    let id, name: String?
}

