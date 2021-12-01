//
//  APODItemView.swift
//  Planetarium
//
//  Created by Mikael Holm on 4.11.2021.
//
import SwiftUI

struct APODItemView: View {
    let pictureInfo: PictureInfo
    @StateObject var apodItemViewModel: APODItemViewModel = APODItemViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: pictureInfo.mediaType == "image" ? pictureInfo.url : pictureInfo.thumbnailUrl!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(height: 400)
                Text(pictureInfo.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if pictureInfo.mediaType == "video" {
                    Link("Video", destination: URL(string: pictureInfo.url)!)
                }
                
                Text(pictureInfo.explanation)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }.padding()
        }
        .toolbar {
            Button(action: addToFavorite) {
                Image(systemName: apodItemViewModel.isFavorite ? "heart.fill" : "heart")
            }
        }.onAppear() {
            apodItemViewModel.updateIsFavorite(date: pictureInfo.date)
        }
    }
    
    func addToFavorite() {
        apodItemViewModel.toggleFavorite(pictureInfo: pictureInfo)
    }
}

struct APODItemView_Previews: PreviewProvider {
    static var previews: some View {
        APODItemView(pictureInfo: PictureInfo(copyright: nil, date: "2021-11-04", explanation: "This is a cool photo.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Example", url: "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_960.jpg"))
    }
}
