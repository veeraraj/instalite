//
//  AlbumInfo.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

struct AlbumInfo: Codable {
    let data: [AlbumItem]
}

struct AlbumItem: Codable {
    let id, mediaType: String
    let timestamp: String
    let mediaURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case mediaType = "media_type"
        case timestamp = "timestamp"
        case mediaURL = "media_url"
    }
}
