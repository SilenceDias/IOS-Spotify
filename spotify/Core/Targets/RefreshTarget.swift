//
//  RefreshTarget.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 27.02.2024.
//

//import Foundation
//import Moya
//
//enum RefreshTarget {
//    case refreshToken(refreshToken: String)
//}
//
//extension RefreshTarget: TargetType {
//    var baseURL: URL {
//        return URL(string: GlobalConstants.baseURL + "/api/token")!
//    }
//    
//    var path: String {
//        return "/token"
//    }
//    
//    var method: Moya.Method {
//        return .post
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .getAccessToken(let code) :
//            return .requestParameters(
//                parameters: [
//                    "grant_type": "authorization_code",
//                    "code": code,
//                    "redirect_uri":"https://open.spotify.com/"
//                ],
//                encoding: URLEncoding.default)
//        }
//    }
//    
//    var headers: [String : String]? {
//        var headers = [String : String]()
//        let authString = "\(GlobalConstants.AuthApi.clientId):\(GlobalConstants.AuthApi.clientSecret)"
//        guard let data = authString.data(using: .utf8) else {
//            print("failure to get base64")
//            return nil
//        }
//        
//        var base64AuthString = data.base64EncodedString()
//        headers["Authorization"] = "Basic \(base64AuthString)"
//        headers["Content-Type"] = "application/x-www-form-urlencoded"
//        
//        return headers
//    }
//}
