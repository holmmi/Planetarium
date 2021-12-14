//
//  APODListView.swift
//  Planetarium
//
//  Created by Mikael Holm on 3.11.2021.
//
import SwiftUI

struct APODListView: View {
    @EnvironmentObject var apodListViewModel: APODListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if apodListViewModel.pictureInfos.isEmpty {
                    Text("loading")
                } else {
                    List (apodListViewModel.pictureInfos) { pictureInfo in
                        ListRow(pictureInfo: pictureInfo)
                    }
                    .listStyle(.grouped)
                }
            }
            .navigationTitle("astronomical-pictures")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
            .environmentObject(APODListViewModel())
    }
}
