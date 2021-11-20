//
//  APODSearchViewModel.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 19.11.2021.
//
import Foundation

class APODSearchViewModel: ObservableObject {
    @Published var pictureInfos: [PictureInfo] = [PictureInfo]()
    private var searchData: SearchData? = nil
    private let apodRequest = APODRequest()
    
    
    func getSearchData(searchData: SearchData) {
        self.searchData = searchData
        apodRequest.getPictureInfos(startDate: searchData.startDate, endDate: searchData.endDate) { (result) in
            switch result {
            case .success(let infos):
                DispatchQueue.main.async {
                    if infos.count > Int(searchData.picAmount) ?? 25 {
                        self.pictureInfos = Array(infos[0..<(Int(searchData.picAmount) ?? 50)])
                    } else {
                        self.pictureInfos = infos
                    }
                    
                }
                print("Successfuly loaded pictures.")
            case .failure(let error):
                print("There was an error loading pictures: \(error)")
            }
        }
    }
}
