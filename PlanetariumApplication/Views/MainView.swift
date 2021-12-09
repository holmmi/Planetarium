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
    @StateObject var settingsModel = SettingsModel()
    @AppStorage("DarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        TabView {
            APODListView()
                .environmentObject(apodListViewModel)
                .environmentObject(settingsModel)
                .tabItem({
                    Label("pictures".localized(), systemImage: "photo.fill")
                })
            APODSearchView()
                .environmentObject(settingsModel)
                .tabItem({
                    Label("search".localized(), systemImage: "magnifyingglass")
                })
            FavoritesListView()
                .environmentObject(settingsModel)
                .environmentObject(favoritesListViewModel)
                .tabItem({
                    Label("favorites".localized(), systemImage: "star")
                })
            SatelliteView()
                .environmentObject(settingsModel)
                .tabItem {
                    Label("satellite".localized(), systemImage: "livephoto")
                }
        }
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .accentColor(.planetariumPrimary)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
