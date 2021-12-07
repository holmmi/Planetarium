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
            List (apodListViewModel.pictureInfos) { pictureInfo in
                NavigationLink(destination: APODItemView(pictureInfo: pictureInfo).navigationTitle("picture \(pictureInfo.date)")) {
                    APODListItemView(pictureInfo: pictureInfo)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Label("settings", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("astronomical-pictures")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        APODListView()
            .environmentObject(APODListViewModel())
    }
}
