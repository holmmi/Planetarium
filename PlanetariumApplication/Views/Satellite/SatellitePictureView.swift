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
                    AsyncImage(url: URL(string: earthAsset.url)!) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 300)
                }
            } else {
                VStack {
                    Text("Satellite Picture Loading Failed")
                }
                .padding()
            }
        }
        .onAppear(perform: {
            satellitePictureViewModel.getEarthAssets(latitude: Float(latitude), longitude: Float(longitude))
        })
    }
}

/*struct SatellitePictureView_Previews: PreviewProvider {
    static var previews: some View {
        SatellitePictureView()
    }
}*/
