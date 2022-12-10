//
//  MediaRepositoryEndpoints.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

enum MediaRepositoryEndpoints {
    
    case fetchMediaInfo
    case fetchAlbumInfo(albumId: String)
    
    func createRequest(environment: Environment) -> NetworkRequest {
        return NetworkRequest(url: buildURL(from: environment), headers: nil, requestTimeOut: requestTimeOut, httpMethod: httpMethod, queryParams: buildQueryParams(environment))
    }
}

private extension MediaRepositoryEndpoints {
    var requestTimeOut: Float {
        switch self {
        case .fetchMediaInfo, .fetchAlbumInfo:
            return 30
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchMediaInfo, .fetchAlbumInfo:
            return .GET
        }
    }
    
    func buildQueryParams(_ environment: Environment) -> QueryParams {
        switch self {
        case .fetchMediaInfo:
            return ["fields": "id,caption,media_type,timestamp,thumbnail_url,media_url", "access_token": environment.accessToken]
        case .fetchAlbumInfo:
            return ["fields": "id,media_type,timestamp,thumbnail_url,media_url", "access_token": environment.accessToken]
        }
    }
    
    func buildURL(from environment: Environment) -> String {
        switch self {
        case .fetchMediaInfo:
            return environment.allMediaURLString
        case .fetchAlbumInfo(let albumId):
            return environment.albumDetailsURLString(for: albumId)
        }
    }
}
