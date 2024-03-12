//
//  AuthViewModel.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 22.02.2024.
//

import Foundation

class AuthViewModel {
    func exchangeCodeForToken(code:String, completion: @escaping (Bool) -> Void) {
        AuthManager.shared.changeCodeToToken(code: code) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
