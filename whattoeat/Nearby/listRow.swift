//
//  listRow.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/14/26.
//  used to create the rows of both the favorite, and nearby list
import SwiftUI
struct listRow: View {
    let restaurant: Restaurant
    var body: some View {
        HStack(spacing: spacing.sm) {
            Image(systemName: AppIcon.restaurant)
                .font(.title2)
                .foregroundStyle(colors.accent)
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)
                
                if !restaurant.address.isEmpty {
                    Text(restaurant.address)
                        .font(.caption)
                        .foregroundStyle(colors.secondaryText)
                        .lineLimit(1)
                }
            }
        }
    }
}
