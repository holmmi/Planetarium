//
//  SatellitePictureViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 29.11.2021.
//

import Foundation
import MapKit
import Photos

class SatellitePictureViewModel: ObservableObject {
    private let earthAssetsRequest = EarthAssetsRequest()
    
    @Published var earthAsset: EarthAsset?
    @Published var requestFailed: Bool = false
    @Published var uiImage: UIImage?
    @Published var imageIsSaved: Bool = false
    @Published var permissionIsDenied: Bool = false
    
    func getEarthAssets(latitude: Float, longitude: Float) {
        earthAssetsRequest.getEarthAssets(latitude: latitude, longitude: longitude, completion: { (result) in
            switch result {
            case .success(let earthAsset):
                DispatchQueue.main.async {
                    self.earthAsset = earthAsset
                }
                self.earthAssetsRequest.getImage(url: earthAsset.url, completion: { (imageResult) in
                    switch imageResult {
                    case .success(let uiImage):
                        DispatchQueue.main.async {
                            self.uiImage = uiImage
                        }
                    case .failure(let error):
                        let requestError = error as! EarthAssetsRequestError
                        print("Error: \(requestError.errorMsg), \(requestError.errorKind)")
                    }
                })
            case .failure(let error):
                print("getEarthAssets request failed: \(error)")
                DispatchQueue.main.async {
                    self.requestFailed = true
                }
            }
        })
    }
    
    func getEarthAssetDate() -> String {
        let df1 = DateFormatter()
        df1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        guard let dateString = earthAsset?.date else {
            return "Unknown"
        }
        let date = df1.date(from: dateString)!
        let df2 = DateFormatter()
        df2.dateFormat = "yyyy-MM-dd"
        return df2.string(from: date)
    }
    
    func saveSatellitePicture() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { (status) in
            if status == .authorized {
                if let uiImage = self.uiImage {
                    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                    DispatchQueue.main.async {
                        self.imageIsSaved = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.permissionIsDenied = true
                }
            }
        }
    }
}
