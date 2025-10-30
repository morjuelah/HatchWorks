//
//  HatchWorksCodeChallengeApp.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI
import SwiftData

@main
struct HatchWorksCodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.colorScheme, .dark)
        }
        .modelContainer(for: [CategoryList.self, VideoItem.self, Genre.self])
    }
}
