//
//  HomeViewModel.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation
import Logging

final class HomeViewModel {
    // MARK: Properties
    weak var coordinator: AppCoordinator?
    private let accountInfoRepository: AccountRepositoryProtocol
    private let mediaInfoRepository: MediaRepositoryProtocol
    private let logger: Logger
    private(set) var accountInfo: AccountInfo? {
        didSet {
            didReceieveAccountInfo()
        }
    }
    private(set) var error: Error? {
        didSet {
            didReceiveError()
        }
    }
    private(set) var mediaInfo: MediaInfo? {
        didSet {
            didReceieveMediaInfo()
        }
    }
    
    var didReceieveAccountInfo : (() -> ()) = {}
    var didReceieveMediaInfo : (() -> ()) = {}
    var didReceiveError : (() -> ()) = {}
    
    // MARK: Init
    
    init(
        accountInfoRepository: AccountRepositoryProtocol,
        mediaInfoRepository: MediaRepositoryProtocol,
        logger: Logger = AppRepository.shared.logger
    ) {
        self.accountInfoRepository = accountInfoRepository
        self.mediaInfoRepository = mediaInfoRepository
        self.logger = logger
    }
}

// MARK: Public methods

extension HomeViewModel {
    func viewDidLoad() {
        fetchAccountInfo()
    }
    
    func didTapReload() {
        fetchAccountInfo()
    }
    
    func didTapMediaItem(_ mediatItem: MediaItem) {
        coordinator?.showMediaDetails(mediatItem)
    }
}

// MARK: Private methods

private extension HomeViewModel {
    func fetchAccountInfo() {
        Task {
            do {
                accountInfo = try await accountInfoRepository.fetchAccountInfo()
                if accountInfo?.id.isEmpty == false {
                    mediaInfo = try await mediaInfoRepository.fetchMediaInfo()
                } else {
                    error = NetworkError.unknown
                }
            } catch let fetchError {
                logger.error("\(fetchError)")
                error = fetchError
            }
        }
        
//                accountInfo = AccountInfo(id: "hello", username: "1234", media_count: 8)
//                mediaInfo = MediaInfo(data: [MediaItem(id: "3454", mediaType: "CAROUSEL_ALBUM", timestamp: "122212255", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ANo9K5cEAAAA&oh=00_AfCK2dMK_xVNl8z1aITiUPkPBHE0h9ZnvHA8VCTowFPt8A&oe=6399C211", caption: "tryout")])
    }
}
