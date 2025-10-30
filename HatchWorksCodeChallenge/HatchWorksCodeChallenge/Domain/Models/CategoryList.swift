//
//  CategoryList.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

@Model
final class CategoryList: @unchecked Sendable {
    var category: ItemCategory
    var page: Int
    var totalPages: Int
    var totalResults: Int
    var videoItems: [VideoItem]

    init(category: ItemCategory, page: Int = 1, totalPages: Int = 0, totalResults: Int = 0, videoItems: [VideoItem] = []) {
        self.category = category
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.videoItems = videoItems
    }
}
