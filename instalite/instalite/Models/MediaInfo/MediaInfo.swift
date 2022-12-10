//
//  MediaInfo.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

struct MediaInfo: Codable {
    let data: [MediaItem]
}

struct MediaItem: Codable {
    let id, mediaType: String
    let timestamp: String
    let mediaURL: String
    let caption: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mediaType = "media_type"
        case timestamp = "timestamp"
        case mediaURL = "media_url"
        case caption = "caption"
    }
}
