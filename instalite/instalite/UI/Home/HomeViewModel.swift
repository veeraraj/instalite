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
    
    @MainActor
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
    }
}
