//
//  SatelliteView.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 19.11.2021.
//

import SwiftUI
import MapKit

struct SatelliteView: View {
    @StateObject private var satelliteViewModel = SatelliteViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $satelliteViewModel.region, annotationItems: [satelliteViewModel.mapMarker])
            { place in
                MapMarker(coordinate: place.location, tint: .red)
            }
            VStack {
                MapSearchBarView(satelliteViewModel: satelliteViewModel)
                    .padding(.top, 50.0)
                Spacer()
                HStack {
                    Button(action: {
                        satelliteViewModel.setRegionByUserLocation()
                    }) {
                        Image(systemName: "location")
                    }
                    Spacer()
                }
                .padding([.leading, .bottom, .trailing], 25.0)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            satelliteViewModel.locationManager.startUpdating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                satelliteViewModel.setRegionByUserLocation()
            }
        })
    }
}

struct SatelliteView_Previews: PreviewProvider {
    static var previews: some View {
        SatelliteView()
    }
}
