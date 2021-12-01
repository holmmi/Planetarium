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
            APODSearchView()
                .tabItem({
                    Label("search", systemImage: "magnifyingglass")
                })
            SatelliteView()
                .tabItem {
                    Label("Satellite", systemImage: "livephoto")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
