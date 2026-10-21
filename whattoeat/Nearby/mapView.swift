//
//  mapView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/20/26.
//  map veiw for nearby
import SwiftUI
import MapKit

struct NearbyMapView: View {
    @Bindable var viewModel: nearbyModel
    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            UserAnnotation()
            
            ForEach(viewModel.restaurants) { restaurant in
                Annotation(restaurant.name, coordinate: restaurant.coordinate) {
                    Image(systemName: AppIcon.restaurant)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(spacing.xs)
                        .background(colors.accent, in: Circle())
                        .onTapGesture {
                            viewModel.selectedRestaurant = restaurant
                        }
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onMapCameraChange { context in
            viewModel.visibleRegion = context.region
        }
    }
}

