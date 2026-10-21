//
//  nearbyModel.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/20/26.
//  
import Foundation
import CoreLocation
import Observation
import MapKit
import SwiftUI 
@MainActor
@Observable
final class nearbyModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var visibleRegion: MKCoordinateRegion?
    var searchText: String = ""
    var restaurants: [Restaurant] = []
    var selectedRestaurant: Restaurant?
    var isLoading = false
    var displayMode: NearbyDisplayMode = .map
    
    private let searcher = search()
    
    func loadNearby(location: CLLocation) async {
        isLoading = true
        defer { isLoading = false }
        restaurants = (try? await searcher.searchNearby(location: location)) ?? []
    }
    
    func searchTyped() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty, let region = visibleRegion else { return }
        
        isLoading = true
        defer { isLoading = false }
        restaurants = (try? await searcher.search(query: trimmed, region: region)) ?? []
    }
}

enum NearbyDisplayMode: String, CaseIterable, Identifiable {
    case map, list
    var id: Self { self }
}
