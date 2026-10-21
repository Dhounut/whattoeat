//
//  Constants.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import Foundation
import MapKit

nonisolated enum constants {
    static let search: Double = 5000
    static let maxResults = 25
    static let spinDuration: TimeInterval = 3.0
    static let restaurantTypes: [MKPointOfInterestCategory] = [
        .restaurant, .cafe, .bakery, .brewery
    ]
}

nonisolated enum storage {
    static let favorites = "favorites"
}
