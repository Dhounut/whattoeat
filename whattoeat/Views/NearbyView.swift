//
//  NearbyView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import SwiftUI
import MapKit

struct NearbyView: View {
    @State private var viewModel = nearbyModel()
    @Environment(location.self) private var locations
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            VStack(spacing: 0) {
                Picker("", selection: $vm.displayMode) {
                    Image(systemName: AppIcon.mapView).tag(NearbyDisplayMode.map)
                    Image(systemName: AppIcon.listView).tag(NearbyDisplayMode.list)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, spacing.md)
                .padding(.vertical, spacing.xs)
                
                switch viewModel.displayMode {
                case .map:
                    NearbyMapView(viewModel: viewModel)
                case .list:
                    NearbyListView(viewModel: viewModel)
                }
            }
            .navigationTitle("Nearby")
            .searchable(text: $vm.searchText, prompt: "Search restaurants")
            .onSubmit(of: .search) {
                Task { await viewModel.searchTyped() }
            }
            .sheet(item: $vm.selectedRestaurant) { restaurant in
                restaurantDetails(restaurant: restaurant)
            }
            .task {
                if !locations.isAuthorized {
                    locations.requestAuthorization()
                }
                locations.requestLocation()
                
                for _ in 0..<10 {
                    if let loc = locations.currentLocation {
                        await viewModel.loadNearby(location: loc)
                        return
                    }
                    try? await Task.sleep(for: .milliseconds(300))
                }
            }
        }
    }
}
