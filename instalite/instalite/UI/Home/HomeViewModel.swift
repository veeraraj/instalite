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
                let accountInfoObject = try await mediaInfoRepository.fetchAlbumInfo(for: "17880028738697994" )
                print("accountInfoObject", accountInfoObject)
            } catch let fetchError {
                logger.error("\(fetchError)")
            }
        }
    }
}
