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
    @State private var isAlertShowing = false
    
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
                        if satelliteViewModel.locationManager.getAuthorizationStatus() == .denied {
                            isAlertShowing.toggle()
                        } else {
                            satelliteViewModel.setRegionByUserLocation()
                        }
                    }) {
                        Image(systemName: "location")
                    }
                    .alert(isPresented: $isAlertShowing) {
                        Alert(title: Text("Notice"), message: Text("Location Authorization Is Missing"), dismissButton: .cancel())
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
