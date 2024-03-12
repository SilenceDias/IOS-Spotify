//
//  MainPageManager.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 09.03.2024.
//

import Foundation
import Moya

final class MainPageManager {
    static let shared = MainPageManager()
    
    private let provider = MoyaProvider<MainPageTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    func getAlbums(completion: @escaping ([Playlist]) -> ()){
        provider.request(.getNewReleases) { result in
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let data = try? JSONDecoder().decode(NewReleased.self, from: response.data) else {
                    break
                }
                completion(data.albums.items)
            case .failure(let error):
                break
            }

        }
    }
    
    func getPlaylists(completion: @escaping ([PlaylistEntity]) -> ()){
        provider.request(.getFeaturedPlaylists) { result in
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let data = try? JSONDecoder().decode(FeaturedPlaylists.self, from: response.data) else {
                    break
                }
                completion(data.playlists.items)
            case .failure(let error):
                break
            }
        }
    }
    
    func getRecomendations(genres: String, completion: @escaping ([Track]) -> ()){
        provider.request(.getReccomendations(genres: genres)) { result in
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let data = try? JSONDecoder().decode(Recomended.self, from: response.data) else {
                    break
                }
                completion(data.tracks)
            case .failure(let error):
                break
            }
        }
    }
    
    func getRecomendedGenres(completion: @escaping ([String]) -> ()){
        provider.request(.getRecomendedGenres) { result in
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let data = try? JSONDecoder().decode(RecomendedGenres.self, from: response.data) else {
                    break
                }
                completion(data.genres)
            case .failure(let error):
                break
            }
        }
    }
}
