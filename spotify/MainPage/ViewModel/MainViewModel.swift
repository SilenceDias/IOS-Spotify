//
//  MainViewModel.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 10.02.2024.
//

import UIKit

class MainViewModel {
    //MARK: Properties
    private lazy var items: [RecommendedMusicDataModel] = []
    private lazy var albums: [AlbumsDataModel] = []
    private lazy var playlists: [AlbumsDataModel] = []
    
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
    func getCellOfTableViewModel(at indexPath: IndexPath) -> RecommendedMusicDataModel{
        return items[indexPath.row]
    }
    
    func getCellOfAlbumsViewModel(at indexPath: IndexPath) -> AlbumsDataModel{
        return albums[indexPath.row]
    }
    
    func getCellOfPlaylistsViewModel(at indexPath: IndexPath) -> AlbumsDataModel{
        return playlists[indexPath.row]
    }
    
    func loadRecomendedMusics(comletion: () -> ()) {
        let musics: [RecommendedMusicDataModel] = [
            .init(
                title: "Cozy Coffeehouse",
                subTitle: nil,
                image: UIImage(named: "music1") ?? UIImage()
            ),
            .init(
                title: "Cozy",
                subTitle: "Profile",
                image: UIImage(named: "music2") ?? UIImage()
            ),
            .init(
                title: "cozy clouds",
                subTitle: nil,
                image: UIImage(named: "music3") ?? UIImage()
            )
        ]
        
        self.items = musics
        comletion()
    }
    
    func loadAlbums(comletion: () -> ()) {
        let albums: [AlbumsDataModel] = [
            .init(
                image: UIImage(named: "vultures1_album") ?? UIImage(), title: "Kanye West: Vultures 1"
            ),
            .init(
                image: UIImage(named: "i_am_music_album") ?? UIImage(), title: "Playboi Carti: I am Music"
            ),
            .init(
                image: UIImage(named: "utopia_album") ?? UIImage(), title: "Travis Scott: Utopia"
            )
        ]
        
        self.albums = albums
        comletion()
    }
    
    func loadPlaylists(comletion: () -> ()) {
        let playlists: [AlbumsDataModel] = [
            .init(
                image: UIImage(named: "playlist1") ?? UIImage(), title: "Indie India"
            ),
            .init(
                image: UIImage(named: "playlist2") ?? UIImage(), title: "RADAR India"
            )
        ]
        
        self.playlists = playlists
        comletion()
    }
}
