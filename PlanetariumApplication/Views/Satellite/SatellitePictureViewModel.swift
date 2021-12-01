//
//  SatellitePictureViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 29.11.2021.
//

import Foundation
import MapKit

class SatellitePictureViewModel: ObservableObject {
    private let earthAssetsRequest = EarthAssetsRequest()
    @Published var earthAsset: EarthAsset?
    @Published var requestFailed: Bool = false
    
    func getEarthAssets(latitude: Float, longitude: Float) {
        earthAssetsRequest.getEarthAssets(latitude: latitude, longitude: longitude, completion: { (result) in
            switch result {
            case .success(let earthAsset):
                DispatchQueue.main.async {
                    self.earthAsset = earthAsset
                }
            case .failure(let error):
                print("getEarthAssets request failed: \(error)")
                self.requestFailed = true
            }
        })
    }
}
