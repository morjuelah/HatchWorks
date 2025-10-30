//
//  ItemCategory.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation

enum ItemCategory: String, CaseIterable, Codable, Sendable {
    case nowPlayingMovie
    case popularMovie
    case topRatedMovie
    case upcomingMovie
    case airingTodayTV
    case onTheAirTV
    case popularTV
    case topRatedTV

    var url: String {
        switch self {
        case .nowPlayingMovie:
            return "https://api.themoviedb.org/3/movie/now_playing?page=%@"
        case .popularMovie:
            return "https://api.themoviedb.org/3/movie/popular?page=%@"
        case .topRatedMovie:
            return "https://api.themoviedb.org/3/movie/top_rated?page=%@"
        case .upcomingMovie:
            return "https://api.themoviedb.org/3/movie/upcoming?page=%@"
        case .airingTodayTV:
            return "https://api.themoviedb.org/3/tv/airing_today?page=%@"
        case .onTheAirTV:
            return "https://api.themoviedb.org/3/tv/on_the_air?page=%@"
        case .popularTV:
            return "https://api.themoviedb.org/3/tv/popular?page=%@"
        case .topRatedTV:
            return "https://api.themoviedb.org/3/tv/top_rated?page=%@"
        }
    }

    var describingName: String {
        switch self {
        case .nowPlayingMovie:
            return "Now playing"
        case .popularMovie:
            return "Popular"
        case .topRatedMovie:
            return "Top rated"
        case .upcomingMovie:
            return "Upcoming"
        case .airingTodayTV:
            return "Airing today"
        case .onTheAirTV:
            return "On the air"
        case .popularTV:
            return "Popular"
        case .topRatedTV:
            return "Top rated"
        }
    }

    var type: CategoryType {
        switch self {
        case .nowPlayingMovie, .popularMovie, .topRatedMovie, .upcomingMovie:
            return .movie
        case .airingTodayTV, .onTheAirTV, .popularTV, .topRatedTV:
            return .tv
        }
    }
}

enum CategoryType: String, CaseIterable, Codable {
    case movie = "Movies"
    case tv = "TV Series"

    var genreUrl: String {
        switch self {
        case .movie:
            return "https://api.themoviedb.org/3/genre/movie/list"
        case .tv:
            return "https://api.themoviedb.org/3/genre/tv/list"
        }
    }

    var searchUrl: String {
        switch self {
        case .movie:
            return "https://api.themoviedb.org/3/search/movie?query=%@&page=%@"
        case .tv:
            return "https://api.themoviedb.org/3/search/tv?query=%@&page=%@"
        }
    }
}
