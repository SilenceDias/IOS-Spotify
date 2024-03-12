//
//  HomeSectionType.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 02.03.2024.
//

import Foundation

enum HomeSectionType {
    case newRelease(datamodel: [AlbumsDataModel])
    case playlist(datamodel: [AlbumsDataModel])
    case recommended(datamodel: [RecommendedMusicDataModel])
}
