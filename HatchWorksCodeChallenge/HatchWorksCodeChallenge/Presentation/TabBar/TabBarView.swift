//
//  TabBarView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ItemsListView()
                .tabItem {
                    Label("Shows", systemImage: "movieclapper")
                }

            SearchView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        .accentColor(.white)
    }
}

#Preview {
    TabBarView()
}
