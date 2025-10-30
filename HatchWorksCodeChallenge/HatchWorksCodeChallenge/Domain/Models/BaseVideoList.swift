//
//  BaseVideoList.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation

struct BaseVideoList: Codable {
    var page: Int
    var totalPages: Int
    var totalResults: Int
    var videoItems: [VideoItem]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case videoItems = "results"
    }
}
