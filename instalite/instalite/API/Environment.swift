//
//  Environment.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    private enum Constants: String {
        case accessToken = "accessToken"
        case fatalErrorMessage = "You must supply access token in the Info.plist using the key accessToken"
        case baseUrl = "https://graph.instagram.com"
    }
    
    var baseURL: String {
        switch self {
        case .development, .staging, .production:
            return Constants.baseUrl.rawValue
        }
    }
        
    // Access token is stored in Configuration(XCConfig) files as we should not hard code them in the code
    
    var accessToken: String {
        guard
            let accessToken: String = Bundle.fetchValue(for: Constants.accessToken.rawValue),
            !accessToken.isEmpty
        else {
            fatalError(Constants.fatalErrorMessage.rawValue)
        }
        
        return accessToken
    }
}
