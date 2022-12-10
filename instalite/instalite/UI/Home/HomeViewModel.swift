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
    private let logger: Logger
    
    // MARK: Init
    
    init(
        accountInfoRepository: AccountRepositoryProtocol,
        logger: Logger = AppRepository.shared.logger
    ) {
        self.accountInfoRepository = accountInfoRepository
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
                let accountInfoObject = try await accountInfoRepository.fetchAccountInfo()
                print("accountInfoObject", accountInfoObject)
            } catch let fetchError {
                logger.error("\(fetchError)")
            }
        }
    }
}
