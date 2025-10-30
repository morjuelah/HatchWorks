//
//  ItemActionsBarView.swift
//  HatchWorksCodeChallenge
//
//  Created by Miguel Orjuela on 28/10/25.
//

import SwiftUI

struct ItemActionsBarView: View {
    var body: some View {
        HStack(spacing: 16) {
            ActionButton(text: "Add to list", imageSystemName: "plus")
            ActionButton(text: "Share", imageSystemName: "square.and.arrow.up")
            ActionButton(text: "Download", imageSystemName: "arrow.down.circle.dotted")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ActionButton: View {

    var text: String
    var imageSystemName: String

    var body: some View {
        Button {
            //
        } label: {
            VStack(spacing: 4) {
                Image(systemName: imageSystemName)
                    .frame(width: 20, height: 20)
                Text(text)
                    .font(.system(size: 12))
            }
        }
    }
}
