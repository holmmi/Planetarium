//
//  MapSearchBarViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 20.11.2021.
//

import MapKit

class SatelliteViewModel: ObservableObject {
    private(set) var locationManager = LocationManager()
    @Published private(set) var mapItems: [MKMapItem] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 060.223_854,
                                       longitude: 024.758_627),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
    private(set) var mapMarker: IdentifiablePlace = IdentifiablePlace(
        location: CLLocationCoordinate2D(latitude: 060.223_854, longitude: 024.758_627)
    )
    
    func search(query: String) {
        MapSearch.search(query: query, completion: { (result) in
            switch result {
            case .success(let mapItems):
                self.mapItems = mapItems
            case .failure(let error):
                print("There was an error searching locations and places: \(error)")
            }
        })
    }
    
    func getMapInfo() -> [MapInfo] {
        return mapItems.map { MapInfo(placemark: $0.placemark) }
    }
    
    func setRegionByPlacemark(mkPlacemark: MKPlacemark) {
        region = MKCoordinateRegion(center: mkPlacemark.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
        mapMarker = IdentifiablePlace(location: mkPlacemark.coordinate)
    }
    
    func setRegionByUserLocation() {
        if let coordinate = locationManager.lastKnownLocation?.coordinate {
            region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapMarker = IdentifiablePlace(location: coordinate)
        }
    }
}
