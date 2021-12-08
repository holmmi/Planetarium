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
            NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("picture \(pictureInfo.date)").navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)) {
                APODListItemView(pictureInfo: pictureInfo)
            }
        }
        .listStyle(.grouped)
        .onAppear(perform: {
            apodSearchViewModel.getSearchData(searchData: searchData)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: ({
                NavigationBackButton()
            }))
        }
        .navigationBarTitle("search-results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
    }
}


struct APODSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        APODSearchListView()
            .environmentObject(SearchData())
    }
}
