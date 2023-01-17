//
//  DetailsData.swift
//  GameStore
//
//  Created by Melih Yuvacı on 18.01.2023.
//

import Foundation

// MARK: - DetailsData
struct DetailsData: Codable {
    let id: Int?
    let slug, name, nameOriginal, description: String?
    let released: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop, added, gameSeriesCount: Int?
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case description, released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case added
        case gameSeriesCount = "game_series_count"
        case descriptionRaw = "description_raw"
    }
}
