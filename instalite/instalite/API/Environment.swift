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
    private struct Constants {
        static let accessToken = "accessToken"
        static let fatalErrorMessage = "You must supply access token in the Info.plist using the key accessToken"
    }
    
    private var baseURLString: String {
        switch self {
        case .development, .staging, .production:
            return "https://graph.instagram.com"
        }
    }
        
    var accountInfoURLString: String {
        baseURLString + "/me"
    }
    
    // Access token is stored in Configuration(XCConfig) files as we should not hard code them in the code
    
    var accessToken: String {
        guard
            let accessToken: String = Bundle.fetchValue(for: Constants.accessToken),
            !accessToken.isEmpty
        else {
            fatalError(Constants.fatalErrorMessage)
        }
        
        return accessToken
    }
}
