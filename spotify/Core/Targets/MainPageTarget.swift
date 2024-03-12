//
//  NewReleasedTarget.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 09.03.2024.
//

import Foundation
import Moya

enum MainPageTarget {
    case getNewReleases
    case getFeaturedPlaylists
    case getReccomendations(genres: String)
    case getRecomendedGenres
}

extension MainPageTarget: BaseTarget {
    var baseURL: URL {
        return URL(string: GlobalConstants.apiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .getNewReleases:
            return "/v1/browse/new-releases"
        case .getFeaturedPlaylists:
            return "/v1/browse/featured-playlists"
        case .getReccomendations:
            return "/v1/recommendations"
        case .getRecomendedGenres:
            return "/v1/recommendations/available-genre-seeds"
        }
        
    }
    
    var task: Moya.Task {
        switch self {
        case .getNewReleases:
            return .requestParameters(
                parameters: [
                    "limit": 30,
                    "offset": 0
                ],
                encoding: URLEncoding.default)
        case .getFeaturedPlaylists:
            return .requestParameters(
                parameters: [
                    "locale": "sv_SE",
                    "limit": 10,
                    "offset": 5
                ],
                encoding: URLEncoding.default)
        case .getReccomendations(let genres):
            return .requestParameters(
                parameters: [
                    "seed_genres": genres
                ],
                encoding: URLEncoding.default)
        case .getRecomendedGenres:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        var header = [String : String]()
        AuthManager.shared.withValidToken { token in
            header["Authorization"] = " Bearer \(token)"
        }
        return header
    }
}
