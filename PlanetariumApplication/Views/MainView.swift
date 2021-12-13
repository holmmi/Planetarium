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
    
    @AppStorage("darkMode") private var isDarkMode = false
    @AppStorage("language") private var language = Language.english
    
    var body: some View {
        TabView {
            APODListView()
                .environmentObject(apodListViewModel)
                .tabItem({
                    Label("pictures", systemImage: "photo.fill")
                })
            APODSearchView()
                .tabItem({
                    Label("search", systemImage: "magnifyingglass")
                })
            FavoritesListView()
                .environmentObject(favoritesListViewModel)
                .tabItem({
                    Label("favorites", systemImage: "star")
                })
            SatelliteView()
                .tabItem {
                    Label("satellite", systemImage: "livephoto")
                }
            SettingsView()
                .tabItem {
                    Label("settings", systemImage: "gear")
                }
        }
        .environment(\.locale, .init(identifier: language.rawValue))
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .accentColor(.planetariumAccent)
        .onAppear {
            print(language.rawValue)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.portrait)
    }
}
