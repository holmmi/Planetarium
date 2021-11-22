//
//  MapInfo.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 22.11.2021.
//

import MapKit

struct MapInfo: Identifiable {
    let id = UUID()
    let placemark: MKPlacemark
}
