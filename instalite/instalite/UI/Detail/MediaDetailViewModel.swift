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
                let albumInfoObject = try await mediaInfoRepository.fetchAlbumInfo(for: mediaItem.id)
                await MainActor.run {
                    albumInfo = albumInfoObject
                    currentState = albumInfo?.data.isEmpty == true ? .empty : .loaded
                }
            } catch let fetchError {
                logger.error("\(fetchError)")
                currentState = .failure(error: fetchError.localizedDescription)
            }
        }

    }
}

