//
//  APIResult.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 24.02.2024.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case networkFail
    case incorrectJson
    case unknown
    case failedWith(error: String)
}
