//
//  FavoritesListView.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var favoritesListViewModel: FavoritesListViewModel
    @EnvironmentObject var settingsModel: SettingsModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesListViewModel.favorites) { favorite in
                    NavigationLink(destination: FavoritesItemView(favorite: favorite), label:{
                        HStack {
                            AsyncImage(url: URL(string: !favorite.video ? favorite.url! : favorite.thumbnailUrl!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 120, height: 120)
                            VStack(alignment: .leading) {
                                Text(favorite.title!)
                                    .font(.title2)
                                Text(favorite.date!)
                                    .padding(.top)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                    })
                }.onDelete(perform: favoritesListViewModel.deleteFavorite)
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("favorites".localized())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                favoritesListViewModel.getFavorites()
            }
        }
    }
    
    struct FavoritesListView_Previews: PreviewProvider {
        static var previews: some View {
            FavoritesListView()
                .environmentObject(SettingsModel())
        }
    }
}
