//
//  FavoritesView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import SwiftUI

struct FavoritesView: View {
    @Environment(favorites.self) private var favorite
    @State private var selected: Restaurant?
    
    var body: some View {
        Group {
            if favorite.favorites.isEmpty {
                ContentUnavailableView(
                    "No Favorites Yet",
                    systemImage: AppIcon.favorite
                )
            } else {
                List {
                    ForEach(favorite.favorites) { restaurant in
                        Button {
                            selected = restaurant
                        } label: {
                            listRow(restaurant: restaurant)
                        }
                        .buttonStyle(.plain)
                    }
                    .onDelete { indices in
                        for index in indices {
                            favorite.remove(at: index)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Favorites")
        .sheet(item: $selected) { restaurant in
            restaurantDetails(restaurant: restaurant)
        }
    }
}
