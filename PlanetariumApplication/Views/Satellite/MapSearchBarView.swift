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
            HStack {
                TextField("Location Search", text: $searchText)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .focused($isSearching)
                    .onChange(of: searchText) {newValue in
                        satelliteViewModel.search(query: newValue)
                    }
                    .modifier(ClearButton(text: $searchText))
                
                if isSearching {
                    Button(action: {
                        isSearching.toggle()
                        searchText = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.leading, 10)
                }
            }
            
            if isSearching && !satelliteViewModel.mapItems.isEmpty {
                List(satelliteViewModel.getMapInfo()) { mapInfo in
                    Button(action: {
                        satelliteViewModel.setRegionByPlacemark(mkPlacemark: mapInfo.placemark)
                        isSearching.toggle()
                        searchText = ""
                    }) {
                        VStack(alignment: .leading) {
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
                }
                .listStyle(.plain)
                .frame(maxHeight: 250)
            }
            
        }.padding()
    }
}

struct MapSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchBarView(satelliteViewModel: SatelliteViewModel())
    }
}
