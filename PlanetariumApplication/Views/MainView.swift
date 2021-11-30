//
//  MainView.swift
//  Planetarium
//
//  Created by Mikael Holm on 3.11.2021.
//

import SwiftUI

struct MainView: View {
    @StateObject var apodListViewModel = APODListViewModel()
    
    var body: some View {
        TabView {
            APODListView()
                .environmentObject(apodListViewModel)
                .tabItem({
                    Label("Pictures", systemImage: "photo.fill")
                })
            SatelliteView()
                .tabItem {
                    Label("Satellite", systemImage: "livephoto")
                }
            APODSearchView()
                .tabItem({
                    Label("Search", systemImage: "magnifyingglass")
                })
            SpeechToTextView()
                .tabItem({
                    Label("SpeechToText", systemImage: "mic")
                })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
.previewInterfaceOrientation(.portrait)
    }
}
