//
//  CategorySelectionView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct CategorySelectionView: View {

    var categorySelected: CategoryType
    var onChange: ((CategoryType) -> Void)

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ForEach(CategoryType.allCases, id: \.self) { category in
                Button {
                    onChange(category)
                } label: {
                        Text(category.rawValue)
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.white)
                }
                .buttonStyle(.bordered)
                .overlay(content: {
                    if categorySelected == category {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.white, lineWidth: 1)
                    }
                })
                .shadow(color: .black, radius: 4, x: 0, y: 2)
            }
        }
    }
}
