//
//  FavoritesItemViewModel.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//

import Foundation

class FavoritesItemViewModel: ObservableObject {
    
    private let favoriteRepository = FavoriteRepository()
    
   
    func deleteFavoriteByDate(date: String) {
        favoriteRepository.deleteFavoriteByDate(date: date)
    }
    
}
