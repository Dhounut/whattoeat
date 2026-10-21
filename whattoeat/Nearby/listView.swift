//
//  listView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/14/26.
//  manages the list view of nearby
import SwiftUI
struct NearbyListView: View {
    @Bindable var viewModel: nearbyModel
    var body: some View {
        Group {
            if viewModel.restaurants.isEmpty && !viewModel.isLoading {
                ContentUnavailableView(
                    "No Restaurants Yet",
                    systemImage: AppIcon.restaurant,
                    description: Text("Try searching or moving the map.")
                )
            } else {
                List(viewModel.restaurants) { restaurant in
                    Button {
                        viewModel.selectedRestaurant = restaurant
                    } label: {
                        listRow(restaurant: restaurant)
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
            }
        }
    }
}
