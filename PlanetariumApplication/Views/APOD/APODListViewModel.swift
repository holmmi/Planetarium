//
//  APODListViewModel.swift
//  Planetarium
//
//  Created by Mikael Holm on 4.11.2021.
//
import Foundation

class APODListViewModel: ObservableObject {
    @Published var pictureInfos: [PictureInfo] = [PictureInfo]()
    private let apodRequest = APODRequest()
    
    init() {
        apodRequest.getPictureInfos(startDate: Date(timeIntervalSinceNow: -60 * 60 * 24 * 30), endDate: Date()) { (result) in
            switch result {
            case .success(let infos):
                DispatchQueue.main.async {
                    self.pictureInfos = infos
                }
                print("Successfuly loaded pictures.")
            case .failure(let error):
                print("There was an error loading pictures: \(error)")
            }
        }
    }
}
