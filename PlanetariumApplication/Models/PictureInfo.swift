//
//  PictureInfo.swift
//  Planetarium (iOS)
//
//  Created by Mikael Holm on 3.11.2021.
//

import Foundation

struct PictureInfo: Codable, Identifiable {
    let id = UUID()
    let copyright: String?
    let date: String
    let explanation: String
    let hdUrl: String?
    let mediaType: String
    let thumbnailUrl: String?
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdUrl = "hdurl"
        case mediaType = "media_type"
        case thumbnailUrl = "thumbnail_url"
        case title
        case url
    }
}
