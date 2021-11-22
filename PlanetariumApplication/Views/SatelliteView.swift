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
            Map(coordinateRegion: $satelliteViewModel.region)
            VStack {
                MapSearchBarView(satelliteViewModel: satelliteViewModel)
                    .padding(.top, 50.0)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct SatelliteView_Previews: PreviewProvider {
    static var previews: some View {
        SatelliteView()
    }
}
