//
//  FavoritesListView.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//
import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var favoritesListViewModel: FavoritesListViewModel
    
    var body: some View {
        NavigationView {
            if favoritesListViewModel.favorites.isEmpty{
                VStack{
                Image(systemName: "shippingbox").font(.system(size: 100).weight(.thin))
                    Text("no-items").font(.title2).padding()
                    Text("favorites-hint").multilineTextAlignment(.center)
                }
                .navigationTitle("favorites")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
            }
            else{
            List {
                ForEach(favoritesListViewModel.favorites) { favorite in
                    NavigationLink(destination: FavoritesItemView(favorite: favorite)
                                    .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white), label:{
                        HStack {
                            AsyncImage(url: URL(string: !favorite.video ? favorite.url! : favorite.thumbnailUrl!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 120, height: 120)
                            VStack(alignment: .leading) {
                                Text(favorite.title!)
                                    .font(.title2)
                                Text(favorite.date?.formattedDate() ?? "")
                                    .padding(.top)
                                Spacer()
                            }
                            Spacer()
                        }
                    })
                }
                .onDelete(perform: favoritesListViewModel.deleteFavorite)
            }
            .listStyle(GroupedListStyle())
            .listStyle(.grouped)
            .navigationTitle("favorites")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white)
            }
        }
        .onAppear{
            favoritesListViewModel.getFavorites()
        }
    }
    
    struct FavoritesListView_Previews: PreviewProvider {
        static var previews: some View {
            FavoritesListView()
        }
    }
}
