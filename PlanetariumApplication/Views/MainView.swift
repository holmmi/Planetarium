//
//  MainView.swift
//  Planetarium
//
//  Created by Mikael Holm on 3.11.2021.
//

import SwiftUI

struct MainView: View {
    @StateObject var apodListViewModel = APODListViewModel()
    @StateObject var favoritesListViewModel = FavoritesListViewModel()

    
    var body: some View {
        TabView {
            APODListView()
                .environmentObject(apodListViewModel)
                .tabItem({
                    Label("Pictures", systemImage: "photo.fill")
                })
            APODSearchView()
                .tabItem({
                    Label("Search", systemImage: "magnifyingglass")
                })
            FavoritesListView()
                .environmentObject(favoritesListViewModel)
                .tabItem({
                    Label("Favorites", systemImage: "star")
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
