//
//  APODListItem.swift
//  Planetarium
//
//  Created by Mikael Holm on 4.11.2021.
//
import SwiftUI

struct APODListItemView: View {
    var pictureInfo: PictureInfo
    @EnvironmentObject var apodItemViewModel: APODItemViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pictureInfo.mediaType == "image" ? pictureInfo.url : pictureInfo.thumbnailUrl!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 120, height: 120)
            VStack(alignment: .leading) {
                HStack {
                    Text(pictureInfo.title)
                        .font(.title2)
                    if apodItemViewModel.isFavorite {
                        Spacer()
                        Image(systemName: "heart.fill")
                    }
                }
                Text(pictureInfo.date)
                    .padding(.top)
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            apodItemViewModel.updateIsFavorite(date: pictureInfo.date)
        }
    }
       
}

struct APODListItem_Previews: PreviewProvider {
    static var previews: some View {
        APODListItemView(pictureInfo: PictureInfo(copyright: nil, date: "2021-11-04", explanation: "This is a cool photo.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Example", url: "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_960.jpg"))
            .environmentObject(APODItemViewModel())
    }
}
