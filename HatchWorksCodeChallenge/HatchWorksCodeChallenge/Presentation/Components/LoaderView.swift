//
//  LoaderView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
            ProgressView {
                Text("Loading all your favorite shows...")
                    .font(.system(size: 14))
            }
    }
}

#Preview {
    LoaderView()
}
