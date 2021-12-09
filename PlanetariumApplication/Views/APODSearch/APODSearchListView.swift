//
//  APODSearchListView.swift
//  PlanetariumApplication
//
//  Created by Tiitus Telke on 19.11.2021.
//

import SwiftUI

struct APODSearchListView: View {
    @EnvironmentObject var searchData: SearchData
    @StateObject var apodSearchViewModel: APODSearchViewModel = APODSearchViewModel()
    
    var body: some View {
        List (apodSearchViewModel.pictureInfos) { pictureInfo in
            NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("picture \(pictureInfo.date)")) {        // TODO: find a way to localize this on the fly with localize() or similar
                APODListItemView(pictureInfo: pictureInfo)
            }
        }
        .onAppear(perform: {
            apodSearchViewModel.getSearchData(searchData: searchData)
        })
        .navigationBarTitle("search-results".localized())
        .navigationBarTitleDisplayMode(.inline)
    }
        
    
}


struct APODSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchListView()
            .environmentObject(SearchData())
    }
}
