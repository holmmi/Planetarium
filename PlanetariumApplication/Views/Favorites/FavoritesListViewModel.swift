//
//  FavoritesListViewModel.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//

import Foundation

class FavoritesListViewModel: ObservableObject {
    @Published var favorites: [Favorite] = [Favorite]()
    private let favoriteRepository = FavoriteRepository()
    
    func deleteFavorite(index: IndexSet) {
        for i in index {
            favoriteRepository.deleteFavorite(favorite: favorites[i])
        }
        getFavorites()
    }
    
    func deleteFavorite(favorite: Favorite) {
        favoriteRepository.deleteFavorite(favorite: favorite)
        getFavorites()
    }
    
    func getFavorites() {
        favorites = favoriteRepository.getFavorites()
    }
}

