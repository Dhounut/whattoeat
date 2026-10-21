//
//  restaurant.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/14/26.
//  creates restaurant info for use lter
import Foundation
import CoreLocation
import MapKit

struct Restaurant: Identifiable, Codable, Hashable, Sendable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(from mapItem: MKMapItem) {
        self.id = UUID()
        self.name = mapItem.name ?? "Unknown"
        self.latitude = mapItem.location.coordinate.latitude
        self.longitude = mapItem.location.coordinate.longitude
        self.address = mapItem.addressRepresentations?.fullAddress(includingRegion: false, singleLine: true) ?? ""
    }
    func makeMapItem() -> MKMapItem {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(location: location, address: nil)
        mapItem.name = name
        return mapItem
    }
}
extension Restaurant {
    init(id: UUID = UUID(), name: String, latitude: Double, longitude: Double, address: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
}
