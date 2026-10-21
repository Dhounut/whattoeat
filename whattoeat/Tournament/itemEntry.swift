//
//  itemEntry.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 5/2/26.
//  used to create the little chips that appear when items are entered

import SwiftUI

struct itemEntry: View {
    let entry: String
    let onRemove: () -> Void
    var body: some View {
        HStack(spacing: 4) {
            Text(entry).font(.subheadline)
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, spacing.sm)
        .padding(.vertical, spacing.xs)
        .clipShape(Capsule())
    }
}
