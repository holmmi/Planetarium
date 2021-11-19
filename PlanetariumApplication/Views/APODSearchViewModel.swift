//
//  APODSearchViewModel.swift
//  PlanetariumApplication
//
//  Created by iosdev on 19.11.2021.
//

import Foundation
import SwiftUI

class APODSearchViewModel: ObservableObject {
    @State var startDate = Date()
    @State var endDate = Date()
    @State var picAmount: String = "0"
    
    @Published var pictureInfos: [PictureInfo] = [PictureInfo]()
    private let apodRequest = APODRequest()
    
    func getPictures() {
        print(startDate)
        apodRequest.getPictureInfos(startDate: startDate, endDate: endDate) { (result) in
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
