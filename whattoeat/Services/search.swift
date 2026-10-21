//
//  search.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/20/26.
//  used for searching
import Foundation
import MapKit
import CoreLocation

final class search {
    func search(query: String, region: MKCoordinateRegion) async throws -> [Restaurant] {
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.pointOfInterestFilter = MKPointOfInterestFilter(
            including: constants.restaurantTypes
        )
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems
            .prefix(constants.maxResults)
            .map { Restaurant(from: $0) }
    }
    func searchNearby(location: CLLocation) async throws -> [Restaurant] {
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: constants.search,
            longitudinalMeters: constants.search
        )
        return try await search(query: "restaurant", region: region)
    }
}
