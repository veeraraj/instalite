//
//  AccountRepository.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

protocol AccountRepositoryProtocol {
    func fetchAccountInfo() async throws -> AccountInfo
}

class AccountRepository: AccountRepositoryProtocol {
    
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
}
