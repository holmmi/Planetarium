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
        if apodSearchViewModel.pictureInfos.isEmpty {
            Text("loading".localized())
                .onAppear(perform: {
                    apodSearchViewModel.getSearchData(searchData: searchData)
                })
        }
        else {
            List (apodSearchViewModel.pictureInfos) { pictureInfo in
                NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("picture \(pictureInfo.date)").navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)) { //TODO: find a way to localize this on the fly with localize() or similar
                    APODListItemView(pictureInfo: pictureInfo, isFavorite: apodSearchViewModel.isInFavorites(pictureInfo.date))
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: ({
                    NavigationBackButton()
                }))
            }
            .navigationBarTitle("search-results".localized())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
        }
        
    }
    
}


struct APODSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchListView()
            .environmentObject(SearchData())
    }
}
