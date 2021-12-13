//
//  FavoritesItemView.swift
//  PlanetariumApplication
//
//  Created by Lauri Kettunen on 22.11.2021.
//

import SwiftUI

struct FavoritesItemView: View {
    let favorite: Favorite
    
    @EnvironmentObject var favoritesListViewModel: FavoritesListViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: (!favorite.video ? favorite.url : favorite.thumbnailUrl) ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(height: 400)
                
                Text(favorite.title ?? "")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if favorite.video {
                    Link("video".localized(), destination: URL(string: favorite.url ?? "")!)
                }
                
                Text(favorite.explanation ?? "")
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }.padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading, content: ({
                NavigationBackButton()
            }))
            ToolbarItem(placement: .navigationBarTrailing, content: ({
                Button(action: ({
                    showDeleteConfirmation.toggle()
                })) {
                    Image(systemName: "trash")
                }
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            }))
        }
        .alert("delete-favorite-title".localized(), isPresented: $showDeleteConfirmation, actions: ({
            Button("delete-favorite-destructive".localized(), role: .destructive, action: ({
                self.presentationMode.wrappedValue.dismiss()
                favoritesListViewModel.deleteFavorite(favorite: favorite)
            }))
            Button("delete-favorite-cancel".localized(), role: .cancel, action: ({
                
            }))
        }), message: ({
            Text("delete-favorite-message".localized())
        }))
        .navigationBarBackButtonHidden(true)
    }
    
    struct FavoritesItemView_Previews: PreviewProvider {
        static var previews: some View {
            FavoritesItemView(favorite: Favorite())
        }
    }
    
}
