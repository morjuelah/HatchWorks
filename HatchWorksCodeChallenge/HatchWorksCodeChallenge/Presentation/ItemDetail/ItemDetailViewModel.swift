//
//  ItemDetailViewModel.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import Foundation
import SwiftData

@Observable
final class ItemDetailViewModel {

    private var repository: ItemsRepositoryProtocol
    private var categoryType: CategoryType

    var genres: [Genre] = []
    var item: VideoItem

    var modelContext: ModelContext? {
        didSet {
            self.repository.modelContext = self.modelContext
        }
    }

    var genresText: String {
        return genres.map { $0.name }.joined(separator: " • ")
    }

    init(repository: ItemsRepositoryProtocol = ItemsRepository(), item: VideoItem, categoryType: CategoryType) {
        self.repository = repository
        self.item = item
        self.categoryType = categoryType
    }

    func getData(with context: ModelContext) {
        self.modelContext = context

        guard let itemGenres = item.genres, !itemGenres.isEmpty else {
            return
        }

        Task { @MainActor in
            do {
                genres = try await repository.getItemGenres().filter({ genre in
                    if genre.category == categoryType {
                        if let _ = itemGenres.first(where: { genreId in
                            return genreId == genre.id
                        }) {
                            return true
                        }
                    }

                    return false
                })
            } catch {
                //
            }
        }
    }
}
