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
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            HStack {
                TextField("location-search", text: $searchText)
                    .disableAutocorrection(true)
                    .focused($isSearching)
                    .onChange(of: searchText) {newValue in
                        satelliteViewModel.search(query: newValue)
                    }
                    .modifier( ClearButton(text: $searchText, isSearching: $isSearching) )
                    .padding(10)
                
                 //TODO: Try to fix text getting under the clearbutton.

                Button(action: initTextToSpeech) {
                    Image(systemName: "mic")
                        .foregroundColor(speechRecognizer.isRecording ? .red : .secondary)
                }
                .padding(10)
            }
            .background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.background))
            //.padding()
            
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
        }
        .padding()
    }
    
    private func initTextToSpeech() {
        isSearching = true
        speechRecognizer.isRecording ? speechRecognizer.stopRecording() : speechRecognizer.record(to: $searchText)
    }
}

struct MapSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchBarView(satelliteViewModel: SatelliteViewModel())
    }
}
