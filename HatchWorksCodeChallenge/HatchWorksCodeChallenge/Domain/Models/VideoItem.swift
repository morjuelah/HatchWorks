//
//  VideoItem.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

@Model
final class VideoItem: Codable, @unchecked Sendable {

    var id: Int
    var originalTitle: String?
    var originalName: String?
    var posterImagePath: String?
    var backdropImagePath: String?
    var title: String?
    var name: String?
    var overview: String?
    var releaseDate: String?
    var firstAirDate: String?
    var genres: [Int]?
    var originalLanguage: String?
    var popularity: Double?
    var voteAverage: Double?
    var voteCount: Int?

    var headerName: String {
        return title ?? name ?? ""
    }

    var originalHeaderName: String {
        return originalTitle ?? originalName ?? ""
    }

    var posterImageUrl: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500" + (posterImagePath ?? ""))
    }

    var backdropImageUrl: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original" + (backdropImagePath ?? ""))
    }

    var releaseYear: String? {

        guard let dateString = (releaseDate ?? firstAirDate) else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(from: dateString) else {
            return nil
        }

        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case originalName = "original_name"
        case posterImagePath = "poster_path"
        case backdropImagePath = "backdrop_path"
        case title
        case name
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case genres = "genre_ids"
        case originalLanguage = "original_language"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(id: Int) {
        self.id = id
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        originalName = try? container.decode(String.self, forKey: .originalName)
        posterImagePath = try? container.decode(String.self, forKey: .posterImagePath)
        backdropImagePath = try? container.decode(String.self, forKey: .backdropImagePath)
        title = try? container.decode(String.self, forKey: .title)
        name = try? container.decode(String.self, forKey: .name)
        overview = try? container.decode(String.self, forKey: .overview)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        firstAirDate = try? container.decode(String.self, forKey: .firstAirDate)
        genres = try? container.decode([Int].self, forKey: .genres)
        originalLanguage = try? container.decode(String.self, forKey: .originalLanguage)
        popularity = try? container.decode(Double.self, forKey: .popularity)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(posterImagePath, forKey: .posterImagePath)
        try container.encode(backdropImagePath, forKey: .backdropImagePath)
        try container.encode(title, forKey: .title)
        try container.encode(name, forKey: .name)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(firstAirDate, forKey: .firstAirDate)
        try container.encode(genres, forKey: .genres)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
    }
}
