//
//  ProfileResponse.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 05.03.2024.
//

import Foundation

struct Profile: Decodable {
    let /*country,*/ displayName, email: String
    let images: [Image]
//    let product: String

    enum CodingKeys: String, CodingKey {
//        case country
        case displayName = "display_name"
        case email
        case images
//        case product
    }
}

// MARK: - Image
struct Image: Decodable {
    let url: String
//    let height, width: Int
}
