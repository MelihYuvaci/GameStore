//
//  SearchData.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import Foundation

struct SearchApi: Codable {
    let count: Int?
    let next: String?
    let results: [SearchData]?
    let userPlatforms: Bool?

    enum CodingKeys: String, CodingKey {
        case count, next, results
        case userPlatforms = "user_platforms"
    }
}

// MARK: - Result
struct SearchData: Codable {
    let slug, name: String?
    let backgroundImage: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case slug, name
        case backgroundImage = "background_image"
        case id
    }
}
