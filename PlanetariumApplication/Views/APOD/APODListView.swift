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
            List (apodListViewModel.pictureInfos) { pictureInfo in
                NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("picture \(pictureInfo.date)".localized())) {
                    APODListItemView(pictureInfo: pictureInfo)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Label("settings".localized(), systemImage: "gear")
                    }
                }
            }
            .navigationTitle("astronomical-pictures".localized())
            .navigationBarTitleDisplayMode(.inline)
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
