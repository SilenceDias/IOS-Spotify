//
//  ProfileTargetType.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 02.03.2024.
//

import Foundation

enum ProfileTargetType {
    case getProfileInfo
}

extension ProfileTargetType: BaseTarget {
    var baseURL: URL {
        return URL(string: "https://api.spotify.com")!
    }
    
    var path: String {
        return "/v1/me"
    }
    
    var headers: [String : String]? {
        var header = [String : String]()
        AuthManager.shared.withValidToken { token in
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }
    
    
}
