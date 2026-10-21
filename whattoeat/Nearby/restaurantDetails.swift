//
//  restaurantDetails.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/14/26.
//  for the restaurant details popup
import SwiftUI
import MapKit

struct restaurantDetails: View {
    let restaurant: Restaurant
    @Environment(\.dismiss) private var dismiss
    @Environment(favorites.self) private var favorite
    var body: some View {
        NavigationStack {
            VStack(spacing: spacing.md) {
                Image(systemName: AppIcon.restaurant)
                    .font(.system(size: 60))
                    .foregroundStyle(colors.accent)
                
                Text(restaurant.name)
                    .font(.title.weight(.bold))
                    .multilineTextAlignment(.center)
                
                if !restaurant.address.isEmpty {
                    Text(restaurant.address)
                        .font(.body)
                        .foregroundStyle(colors.secondaryText)
                        .multilineTextAlignment(.center)
                }
                HStack(spacing: spacing.sm) {
                    Button {
                        favorite.toggle(restaurant)
                    } label: {
                        Label(
                            favorite.contains(restaurant) ? "Favorited" : "Favorite",
                            systemImage: favorite.contains(restaurant) ? AppIcon.favoriteFilled : AppIcon.favorite
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, spacing.xs)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(colors.favoriteHeart)
                    ShareLink(item: shareText, subject: Text(restaurant.name)) {
                        Label("Share", systemImage: AppIcon.share)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, spacing.xs)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(colors.accent)
                }
                .padding(.top, spacing.sm)
                Button {
                    restaurant.makeMapItem().openInMaps()
                } label: {
                    Label("Get Directions", systemImage: AppIcon.directions)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, spacing.xs)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(colors.accent)
                
                Spacer()
            }
            .padding(spacing.lg)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
    private var shareText: String {
        var lines = [restaurant.name]
        if !restaurant.address.isEmpty {
            lines.append(restaurant.address)
        }
        // links to the map
        lines.append("https://maps.apple.com/?ll=\(restaurant.latitude),\(restaurant.longitude)&q=\(restaurant.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? restaurant.name)")
        return lines.joined(separator: "\n")
    }
}
