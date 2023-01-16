//
//  GameData.swift
//  GameStore
//
//  Created by Melih Yuvacı on 17.01.2023.
//

import Foundation

// MARK: - Game
struct ApiData: Codable {
    let count: Int?
    let results: [GameData]?
}

// MARK: - Result
struct GameData: Codable {
    let id: Int?
    let slug, name: String?
    let backgroundImage: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case backgroundImage = "background_image"
    }
}

