//
//  SwiftUIView.swift
//  PlanetariumApplication
//
//  Created by iosdev on 19.11.2021.
//

import SwiftUI

struct APODSearchListView: View {
    @EnvironmentObject var apodSearchViewModel: APODSearchViewModel
    
    var body: some View {
        NavigationView {
            List (apodSearchViewModel.pictureInfos) { pictureInfo in
                NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("Picture \(pictureInfo.date)")) {
                    APODListItemView(pictureInfo: pictureInfo)
                }
            }
        }
    }
}


struct APODSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchListView()
    }
}
