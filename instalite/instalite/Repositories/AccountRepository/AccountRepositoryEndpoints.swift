//
//  AccountRepositoryEndpoints.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

enum AccountRepositoryEndpoints {
    
    case fetchAccountInfo
            
    func createRequest(environment: Environment) -> NetworkRequest {
        return NetworkRequest(url: buildURL(from: environment), headers: nil, requestTimeOut: requestTimeOut, httpMethod: httpMethod, queryParams: buildQueryParams(environment))
    }
}

private extension AccountRepositoryEndpoints {
    var requestTimeOut: Float {
        switch self {
        case .fetchAccountInfo:
            return 30
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchAccountInfo:
            return .GET
        }
    }
    
    func buildQueryParams(_ environment: Environment) -> QueryParams {
        ["fields": "id,username,media_count", "access_token": environment.accessToken]
    }
    
    func buildURL(from environment: Environment) -> String {
        switch self {
        case .fetchAccountInfo:
            return environment.accountInfoURLString
        }
    }
}
