//
//  ProfileManager.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 02.03.2024.
//

import Foundation
import Moya

final class ProfileManager {
    static let shared = ProfileManager()
    
    private let provider = MoyaProvider<ProfileTargetType>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    func getCurrentUserProfile(completion: @escaping (Profile) -> Void) {
        provider.request(.getProfileInfo) { result in
            switch result {
            case .success(let response):
                guard let json = try? JSONSerialization.jsonObject(with: response.data) else { return }
                print("SUCCESS: \(json)")
                guard let profileData = try? response.map(Profile.self) else {
                    break
                }
                completion(profileData)
            case .failure(let error):
                break
            }
        }
    }
}
