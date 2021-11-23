//
//  MapSearchBar.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 20.11.2021.
//

import SwiftUI

struct MapSearchBarView: View {
    @FocusState private var isSearching: Bool
    @State private var searchText = ""
    @ObservedObject var satelliteViewModel: SatelliteViewModel
    
    var body: some View {
        VStack {
            TextField("Location Search", text: $searchText)
                .disableAutocorrection(true)
                .padding(10)
                .background(.white)
                .cornerRadius(10)
                .focused($isSearching)
                .onChange(of: searchText) {newValue in
                    satelliteViewModel.search(query: newValue)
                }
            
            if isSearching && !satelliteViewModel.mapItems.isEmpty {
                List(satelliteViewModel.getMapInfo()) { mapInfo in
                    Button(action: {
                        satelliteViewModel.setRegionByPlacemark(mkPlacemark: mapInfo.placemark)
                        isSearching.toggle()
                    }) {
                        VStack {
                            HStack {
                                Text(mapInfo.placemark.name ?? "-")
                                Spacer()
                            }
                            HStack {
                                Text("\(mapInfo.placemark.postalCode ?? "-"), \(mapInfo.placemark.locality ?? "-")")
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }.listStyle(.inset)
            }
            
        }.padding()
    }
}

struct MapSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchBarView(satelliteViewModel: SatelliteViewModel())
    }
}
