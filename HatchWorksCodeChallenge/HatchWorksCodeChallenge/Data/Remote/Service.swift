//
//  Service.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation

protocol ServiceProtocol {
    func getVideoList(for category: ItemCategory, page: Int) async throws -> BaseVideoList
    func getGenres(for category: CategoryType) async throws -> GenreList
    func searchItems(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList
}

class Service: ServiceProtocol {

    private func serviceRequest<T: Codable>(url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw ServiceError.badURL
        }

        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZGZlNGJhMzdjNjM1ZDBkMzlmZWQwZGI4YjkxNTRlNiIsIm5iZiI6MTcyNjAyNDQ2Ny4yMDY4MzYsInN1YiI6IjY2ZGY1NWZiN2JmN2VmNzNmZGI5NjRlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kcAGVL8z43SOR4QB-CKi0mzIaS8bVRQHbWdKEV7Zbyg"]

        let session = URLSession(configuration: sessionConfiguration)
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }

    func getVideoList(for category: ItemCategory, page: Int) async throws -> BaseVideoList {
        let url = String(format: category.url, String(page))
        return try await serviceRequest(url: url)
    }

    func getGenres(for category: CategoryType) async throws -> GenreList {
        let url = category.genreUrl
        return try await serviceRequest(url: url)
    }

    func searchItems(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList {
        let url = String(format: category.searchUrl, String(searchText), String(page))
        return try await serviceRequest(url: url)
    }
}
