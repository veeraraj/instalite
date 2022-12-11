//
//  MediaDetailViewModel.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import Combine
import Logging

final class MediaDetailViewModel: ObservableObject {
    enum ViewState {
        case idle
        case loading
        case empty
        case loaded
        case failure(error: String)
    }
    
    // MARK: Properties
    
    private let mediaInfoRepository: MediaRepositoryProtocol
    private let logger: Logger
    @Published private(set) var currentState: ViewState = .idle
    @Published private(set) var mediaItem: MediaItem?
    @Published private(set) var albumInfo: AlbumInfo?
    
    // MARK: Init
    
    init(
        selectedMediaItem: MediaItem,
        mediaInfoRepository: MediaRepositoryProtocol,
        logger: Logger = AppRepository.shared.logger
    ) {
        self.mediaInfoRepository = mediaInfoRepository
        self.logger = logger
        
        if selectedMediaItem.isAlbum {
            fetchAlbumDetails(for: selectedMediaItem)
        } else {
            self.mediaItem = selectedMediaItem
            currentState = .loaded
        }
    }
    
    // MARK: Private methods
    
    private func fetchAlbumDetails(for mediaItem: MediaItem) {
        currentState = .loading
        
        Task {
            do {
                albumInfo = try await mediaInfoRepository.fetchAlbumInfo(for: mediaItem.id)
//                albumInfo = AlbumInfo(data: [AlbumItem(id: "1234", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211"),
//                                             AlbumItem(id: "5678", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211"),
//                                             AlbumItem(id: "90102", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211")])
                currentState = albumInfo?.data.isEmpty == true ? .empty : .loaded
            } catch let fetchError {
                logger.error("\(fetchError)")
                currentState = .failure(error: fetchError.localizedDescription)
            }
        }

    }
}

