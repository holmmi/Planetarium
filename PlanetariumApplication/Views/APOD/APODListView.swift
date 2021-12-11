//
//  APODListView.swift
//  Planetarium
//
//  Created by Mikael Holm on 3.11.2021.
//
import SwiftUI

struct APODListView: View {
    @EnvironmentObject var apodListViewModel: APODListViewModel
    @EnvironmentObject var settingsModel: SettingsModel
    
    var body: some View {
        NavigationView {
            if apodListViewModel.pictureInfos.isEmpty {
                Text("loading".localized())
            }
            else {
                List (apodListViewModel.pictureInfos) { pictureInfo in
                    ListRow(pictureInfo: pictureInfo)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Label("settings".localized(), systemImage: "gear")
                                .foregroundColor(.white)
                        }
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("astronomical-pictures".localized())
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
            }
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
            .environmentObject(APODListViewModel())
            .environmentObject(SettingsModel())
    }
}
