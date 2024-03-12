//
//  FeaturedPlaylists.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 12.03.2024.
//

import Foundation

struct FeaturedPlaylists: Decodable {
    let playlists: PlaylistsData
}

struct PlaylistsData: Decodable {
    let items: [PlaylistEntity]
}

struct PlaylistEntity: Decodable {
    let id: String?
    let images: [Image]?
    let name: String?
}



