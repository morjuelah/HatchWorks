//
//  Genre.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

struct GenreList: Codable {
    var genres: [BaseGenre]
}

struct BaseGenre: Codable {
    var id: Int
    var name: String
}

@Model
class Genre: @unchecked Sendable {
    var category: CategoryType
    var id: Int
    var name: String

    init(category: CategoryType, id: Int, name: String) {
        self.category = category
        self.id = id
        self.name = name
    }
}
