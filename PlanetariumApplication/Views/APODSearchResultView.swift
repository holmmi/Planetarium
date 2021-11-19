//
//  APODSearchResultView.swift
//  PlanetariumApplication
//
//  Created by iosdev on 19.11.2021.
//

import SwiftUI

struct APODSearchResultView: View {
    
    var pictureInfo: PictureInfo
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pictureInfo.mediaType == "image" ? pictureInfo.url : pictureInfo.thumbnailUrl!)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 120, height: 120)
            VStack(alignment: .leading) {
                Text(pictureInfo.title)
                    .font(.title2)
                Text(pictureInfo.date)
                    .padding(.top)
                Spacer()
            }
            Spacer()
        }
    }
}


struct APODSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        APODListItemView(pictureInfo: PictureInfo(copyright: nil, date: "2021-11-04", explanation: "This is a cool photo.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Example", url: "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_960.jpg"))
    }
}
