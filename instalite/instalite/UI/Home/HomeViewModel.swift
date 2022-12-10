//
//  HomeViewModel.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation
import Logging
import Combine

final class HomeViewModel {
    // MARK: Properties
    weak var coordinator: AppCoordinator?
    private let accountInfoRepository: AccountRepositoryProtocol
    private let mediaInfoRepository: MediaRepositoryProtocol
    private let logger: Logger
    @Published private(set) var accountInfo: AccountInfo?
    @Published private(set) var error: Error?
    @Published private(set) var mediaInfo: MediaInfo?
    
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
}

// MARK: Private methods

private extension HomeViewModel {
    func fetchAccountInfo() {
        Task {
            do {
                let accountInfoObject = try await accountInfoRepository.fetchAccountInfo()
                accountInfo = accountInfoObject
            } catch let fetchError {
                logger.error("\(fetchError)")
                error = fetchError
            }
        }
    }
}
