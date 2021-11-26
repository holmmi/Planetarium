//
//  APODItemViewModel.swift
//  PlanetariumApplication
//
//  Created by Mikael Holm on 19.11.2021.
//

import Foundation

class APODItemViewModel: ObservableObject {
    @Published private(set) var isFavorite = false
    private let favoriteRepository = FavoriteRepository()
    
    func updateIsFavorite(date: String) {
        isFavorite = favoriteRepository.favoriteExists(date: date)
    }
    
    func toggleFavorite(pictureInfo: PictureInfo) {
        if isFavorite {
            favoriteRepository.deleteFavoriteByDate(date: pictureInfo.date)
        } else {
            favoriteRepository.addFavorite(pictureInfo: pictureInfo)
        }
        isFavorite = favoriteRepository.favoriteExists(date: pictureInfo.date)
    }
}
