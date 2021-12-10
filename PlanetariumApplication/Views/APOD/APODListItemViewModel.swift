//
//  APODListItemViewModel.swift
//  PlanetariumApplication
//
//  Created by iosdev on 10.12.2021.
//

import Foundation

class APODListItemViewModel: ObservableObject {
    @Published private(set) var isFavorite = false
    private let favoriteRepository = FavoriteRepository()
    
    func updateIsFavorite(date: String) {
        isFavorite = favoriteRepository.favoriteExists(date: date)
    }
    
}
