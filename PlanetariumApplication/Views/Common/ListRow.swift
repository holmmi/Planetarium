//
//  ListRow.swift
//  PlanetariumApplication
//
//  Created by iosdev on 11.12.2021.
//

import SwiftUI

struct ListRow: View {
    let pictureInfo: PictureInfo
    @StateObject var apodItemViewModel = APODItemViewModel()
    var body: some View {
        NavigationLink(destination: APODItemView(pictureInfo: pictureInfo)
                        .navigationTitle("picture \(pictureInfo.date.formattedDate())").navigationBarColor(backgroundColor: .planetariumPrimary, titleColor: .white) // TODO: find a way to localize the title on the fly with localize() or similar
                        .environmentObject(apodItemViewModel)) {
            APODListItemView(pictureInfo: pictureInfo).environmentObject(apodItemViewModel)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(pictureInfo: PictureInfo(copyright: nil, date: "2021-11-04", explanation: "This is a cool photo.", hdUrl: nil, mediaType: "image", thumbnailUrl: nil, title: "Example", url: "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_960.jpg"))
    }
}
