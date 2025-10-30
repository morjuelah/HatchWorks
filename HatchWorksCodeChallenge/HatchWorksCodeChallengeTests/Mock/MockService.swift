//
//  MockService.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 29/10/25.
//

import Foundation
@testable import HatchWorksCodeChallenge

class MockService: ServiceProtocol {

    private let emptyBaseVideoList = BaseVideoList(page: 1,
                                                   totalPages: 1,
                                                   totalResults: 0,
                                                   videoItems: [])
    private let emptyGenreList = GenreList(genres: [])

    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            let testBundle = Bundle(for: type(of: self))

            if let fileUrl = testBundle.url(forResource: name, withExtension: "json") {
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }

        return nil
    }

    func getVideoList(for category: ItemCategory, page: Int) async throws -> BaseVideoList {
        guard let jsonData = readLocalJSONFile(forName: "VideoList") else {
            return emptyBaseVideoList
        }

        do {
            let decodedData = try JSONDecoder().decode(BaseVideoList.self, from: jsonData)
            return decodedData
        } catch {
            return emptyBaseVideoList
        }
    }

    func getGenres(for category: CategoryType) async throws -> GenreList {
        guard let jsonData = readLocalJSONFile(forName: "GenreList") else {
            return emptyGenreList
        }

        do {
            let decodedData = try JSONDecoder().decode(GenreList.self, from: jsonData)
            return decodedData
        } catch {
            return emptyGenreList
        }
    }

    func searchItems(for category: CategoryType, searchText: String, page: Int) async throws -> BaseVideoList {
        guard let jsonData = readLocalJSONFile(forName: "SearchResponse") else {
            return emptyBaseVideoList
        }

        do {
            let decodedData = try JSONDecoder().decode(BaseVideoList.self, from: jsonData)
            return decodedData
        } catch {
            return emptyBaseVideoList
        }
    }
}

class MockServiceFailure: ServiceProtocol {

    func getVideoList(for category: HatchWorksCodeChallenge.ItemCategory, page: Int) async throws -> HatchWorksCodeChallenge.BaseVideoList {
        throw ServiceError.default
    }

    func getGenres(for category: HatchWorksCodeChallenge.CategoryType) async throws -> HatchWorksCodeChallenge.GenreList {
        throw ServiceError.default
    }

    func searchItems(for category: HatchWorksCodeChallenge.CategoryType, searchText: String, page: Int) async throws -> HatchWorksCodeChallenge.BaseVideoList {
        throw ServiceError.default
    }
}
