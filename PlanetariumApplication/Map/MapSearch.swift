//
//  MapSearch.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 20.11.2021.
//

import MapKit

struct MapSearch {
    static func search(query: String, completion: @escaping (Result<[MKMapItem], Error>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.resultTypes = [.address, .pointOfInterest]
        
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start(completionHandler: {(response, error) in
            guard let unwrappedResponse = response else {
                completion(.failure(error!))
                return
            }
            completion(.success(unwrappedResponse.mapItems))
        })
    }
}
