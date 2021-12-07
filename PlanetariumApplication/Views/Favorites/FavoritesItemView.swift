//
//  FavoritesItemView.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//

import SwiftUI

struct FavoritesItemView: View {
    
    var favorite: Favorite
    
    @StateObject var favoritesItemViewModel: FavoritesItemViewModel = FavoritesItemViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: !favorite.video ? favorite.url! : favorite.thumbnailUrl!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(height: 400)
                Text(favorite.title!)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if favorite.video {
                    Link("video", destination: URL(string: favorite.url!)!)
                }
                
                Text(favorite.explanation!)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }.padding()
        }

    }
    

    
    
    struct FavoritesItemView_Previews: PreviewProvider {
        static var previews: some View {
            FavoritesItemView(favorite: Favorite())
        }
    }
    
}
