//
//  EarthAsset.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 30.11.2021.
//

import Foundation

struct EarthAsset: Codable {
    let date: String
    let id: String
    let serviceVersion: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case id
        case serviceVersion = "service_version"
        case url
    }
}
