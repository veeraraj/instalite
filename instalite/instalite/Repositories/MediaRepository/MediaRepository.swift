//
//  MediaRepository.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

protocol MediaRepositoryProtocol {
    func fetchMediaInfo() async throws -> MediaInfo
    func fetchAlbumInfo(for albumId: String) async throws -> AlbumInfo
}

class MediaRepository: MediaRepositoryProtocol {
    
    private var networkRequest: NetworkRequestProtocol
    private var environment: Environment
    
    init(networkRequest: NetworkRequestProtocol, environment: Environment = .development) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func fetchAccountInfo() async throws -> AccountInfo {
        let endpoint = AccountRepositoryEndpoints.fetchAccountInfo
        let request = endpoint.createRequest(environment: self.environment)
        return try await self.networkRequest.request(request)
    }
    func fetchMediaInfo() async throws -> MediaInfo {
        let endpoint = MediaRepositoryEndpoints.fetchMediaInfo
        let request = endpoint.createRequest(environment: self.environment)
        return try await self.networkRequest.request(request)
    }
    
    func fetchAlbumInfo(for albumId: String) async throws -> AlbumInfo {
        let endpoint = MediaRepositoryEndpoints.fetchAlbumInfo(albumId: albumId)
        let request = endpoint.createRequest(environment: self.environment)
        return try await self.networkRequest.request(request)
    }
}
