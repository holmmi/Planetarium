//
//  APODSearchViewModel.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 19.11.2021.
//
import Foundation

class APODSearchViewModel: ObservableObject {
    @Published var pictureInfos: [PictureInfo] = [PictureInfo]()
    private var searchData: SearchData!
    private let apodRequest = APODRequest()
    private let favoriteRepository = FavoriteRepository()
    
    func getSearchData(searchData: SearchData) {
        self.searchData = searchData
        if let picAmount = Int(searchData.picAmount) {
            if picAmount > 0 {
                apodRequest.getRandomPictures(picAmount: picAmount) { (result) in
                    switch result {
                    case .success(let infos):
                        DispatchQueue.main.async {
                            self.pictureInfos = infos
                        }
                        print("Successfully loaded pictures.")
                    case .failure(let error):
                        print("There was an error loading pictures: \(error)")
                    }
                }
            }
            else {
                getApodFromDates()
            }
        } else {
            getApodFromDates()
        }
    }
    
    private func getApodFromDates() {
        apodRequest.getPictureInfos(startDate: searchData.startDate, endDate: searchData.endDate) { (result) in
            switch result {
            case .success(let infos):
                DispatchQueue.main.async {
                    self.pictureInfos = infos
                }
                print("Successfully loaded pictures.")
            case .failure(let error):
                print("There was an error loading pictures: \(error)")
            }
        }
    }
    
    func isInFavorites(_ date: String) -> Bool {
        return favoriteRepository.favoriteExists(date: date)
    }
}




