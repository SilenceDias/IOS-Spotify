//
//  GlobalConstants.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 24.02.2024.
//

import Foundation

enum GlobalConstants {
    static let baseURL = "https://accounts.spotify.com"
    static let apiBaseURL = "https://api.spotify.com"
    
    enum AuthApi {
        static let clientId = "e6412845a88545cb9f408a53f178b6ef"
        static let clientSecret = "f420d99a9140469e9ac57618cd539ccc"
        static let scopes = Scopes.allScopes.joined(separator: "%20")
        static let redirectUri = "https://open.spotify.com/"
    }
    
    enum Scopes {
        static let userReadPlaybackState = "user-read-playback-state"
        static let playlistModifyPublic = "playlist-modify-public"
        static let playlistModifyPrivate = "playlist-modify-private"
        static let userFollowRead = "user-follow-read"
        static let userLibraryModify = "user-library-modify"
        static let userReadEmail = "user-read-email"
        
        static let allScopes = [
            userReadPlaybackState,
            playlistModifyPublic,
            playlistModifyPrivate,
            userFollowRead,
            userLibraryModify,
            userReadEmail
        ]
    }
}
