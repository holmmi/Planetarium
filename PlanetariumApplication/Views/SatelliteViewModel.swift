//
//  MapSearchBarViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 20.11.2021.
//

import MapKit

class SatelliteViewModel: ObservableObject {
    @Published private(set) var mapItems: [MKMapItem] = []
    @Published private(set) var placemark: MKPlacemark? = nil
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334_900,
                                       longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
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
    
    func setPlacemark(mkPlacemark: MKPlacemark) {
        placemark = mkPlacemark
        region = MKCoordinateRegion(center: mkPlacemark.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
    }
}
