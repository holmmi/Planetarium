//
//  MapInfo.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 22.11.2021.
//

import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), location: CLLocationCoordinate2D) {
        self.id = id
        self.location = location
    }
}

struct MapInfo: Identifiable {
    let id = UUID()
    let placemark: MKPlacemark
}
