//
//  SatellitePictureView.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 29.11.2021.
//

import SwiftUI
import MapKit

struct SatellitePictureView: View {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    @StateObject private var satellitePictureViewModel = SatellitePictureViewModel()
    
    var body: some View {
        VStack {
            if !satellitePictureViewModel.requestFailed {
                if let earthAsset = satellitePictureViewModel.earthAsset {
                    VStack {
                        AsyncImage(url: URL(string: earthAsset.url)!) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 300, height: 300)
                        Text("Satellite Picture Date \(satellitePictureViewModel.getEarthAssetDate())")
                    }
                }
            } else {
                Text("satellite-picture-loading-failed")
            }
        }
        .onAppear(perform: {
            satellitePictureViewModel.getEarthAssets(latitude: Float(latitude), longitude: Float(longitude))
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    satellitePictureViewModel.saveSatellitePicture()
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                .disabled(satellitePictureViewModel.uiImage == nil)
                .alert("Notice", isPresented: $satellitePictureViewModel.imageIsSaved, actions: ({
                    Button("Ok") {
                        
                    }
                }), message: {
                    Text("Satellite Picture Saved")
                })
                .alert("Notice", isPresented: $satellitePictureViewModel.permissionIsDenied, actions: ({
                    Button("Ok") {
                        
                    }
                }), message: ({
                    Text("Photo Library Permission Denied")
                }))
            }
        }
    }
}

/*struct SatellitePictureView_Previews: PreviewProvider {
    static var previews: some View {
        SatellitePictureView()
    }
}*/
