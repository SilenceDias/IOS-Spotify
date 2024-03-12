//
//  MainViewModel.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 10.02.2024.
//

import UIKit
import Kingfisher

class MainViewModel {
    //MARK: Properties
    private lazy var items: [RecommendedMusicDataModel] = []
    private lazy var albums: [AlbumsDataModel] = []
    private lazy var playlists: [AlbumsDataModel] = []
    private let headers = ["New Released Albums", "Featured Playlists", "Recommended"]
    
    private var sections = [HomeSectionType]()
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func getSectionViewModel(at section: Int) -> HomeSectionType {
        return sections[section]
    }
    
    var numberOfCellsTableView: Int {
        return items.count
    }
    
    var numberOfCellsAlbums: Int {
        return albums.count
    }
    
    var numberOfCellsPlaylists: Int {
        return playlists.count
    }
    
    //MARK: Methods
    
    func didLoad(){
        sections.append(.newRelease(datamodel: []))
        sections.append(.playlist(datamodel: []))
        sections.append(.recommended(datamodel: []))
    }
    
    func loadRecomendedMusics(comletion: () -> () ) {
        MainPageManager.shared.getRecomendedGenres { genres in
            var seeds = Set<String>()
            while seeds.count < 5 {
                if let random = genres.randomElement() {
                    seeds.insert(random)
                }
            }
            let genresSeed = seeds.joined(separator: ",")
            MainPageManager.shared.getRecomendations(genres: genresSeed) { [weak self] items in
                if let index = self?.sections.firstIndex(where: {
                    if case .recommended = $0{
                        return true
                    } else {
                        return false
                    }
                }) {
                    var tracks: [RecommendedMusicDataModel] = []
                    items.forEach {
                        tracks.append(.init(title: $0.album.name ?? "No name", subTitle: $0.artists.first?.name ?? "", imageURL: $0.album.images?.first?.url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"))
                    }
                    self?.sections[index] = .recommended(datamodel: tracks)
                }
            }
        }
        
        comletion()
    }
    
    func loadAlbums(comletion: () -> Void) {
        MainPageManager.shared.getAlbums { [weak self] items in
            if let index = self?.sections.firstIndex(where: {
                if case .newRelease = $0{
                    return true
                } else {
                    return false
                }
            }) {
                var albums: [AlbumsDataModel] = []
                items.forEach {
                    albums.append(.init(imageURL: $0.images[0].url, title: $0.name))
                }
                self?.sections[index] = .newRelease(datamodel: albums)
            }
        }
        comletion()
    }
    
    func loadPlaylists(comletion: () -> Void) {
        MainPageManager.shared.getPlaylists { [weak self] items in
            if let index = self?.sections.firstIndex(where: {
                if case .playlist = $0{
                    return true
                } else {
                    return false
                }
            }) {
                var playlists: [AlbumsDataModel] = []
                items.forEach {
                    playlists.append(.init(imageURL: $0.images?[0].url ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png", title: $0.name ?? "playlist"))
                }
                self?.sections[index] = .playlist(datamodel: playlists)
            }
        }
        comletion()
    }
    
    func getHeadersOfSection(with index: Int) -> String {
        return headers[index]
    }
}
