//
//  AuthManager.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 17.02.2024.
//

import Foundation
import Moya

final class AuthManager {
    static let shared = AuthManager()
    
    private let provider = MoyaProvider<AuthTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    public var signInUrl: URL? {
        let baseURL = GlobalConstants.baseURL + "/authorize"
        
        var components = URLComponents(string: baseURL)
        
        components?.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: GlobalConstants.AuthApi.clientId),
            URLQueryItem(name: "scope", value: GlobalConstants.AuthApi.scopes),
            URLQueryItem(name: "redirect_uri", value: GlobalConstants.AuthApi.redirectUri),
            URLQueryItem(name: "show_dialog", value: "TRUE")
        ]
       
        return components?.url
    }
    
  
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private init() {}
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirasionDate: Date? {
        return UserDefaults.standard.object(forKey: "expiresIn") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let tokenExpirasionDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirasionDate
    }
    
    func changeCodeToToken(code: String, completion: @escaping (APIResult<Void>) -> ()){
        
        provider.request(.getAccessToken(code: code)) {[weak self] result in
            switch result {
            case .success(let response):
                guard let result = try? response.map(AuthResponse.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                self?.cacheToken(result: result)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
        
    }
    
    public func refreshAccessToken(token: String, completion: @escaping (APIResult<Void>) -> ()){
        guard shouldRefreshToken else { return }
        
        provider.request(.refresh(refreshToken: token)) {[weak self] result in
            switch result {
            case .success(let response):
                print("TOKEN REFRESHING")
                guard let result = try? response.map(AuthResponse.self) else {
                    completion(.failure(.incorrectJson))
                    return
                }
                self?.cacheToken(result: result)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    private func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.accessToken, forKey: "accessToken")
        
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expiresIn")
    }
    
}
