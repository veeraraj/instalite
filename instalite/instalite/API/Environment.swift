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
        static let fatalErrorMessage = "noAccessTokenError"
    }
    
    private var baseURLString: String {
        switch self {
        case .development, .staging, .production:
            return "https://graph.instagram.com"
        }
    }
        
    var accountInfoURLString: String {
        "\(baseURLString)/me"
    }
    
    var allMediaURLString: String {
        "\(baseURLString)/me/media"
    }
    
    func albumDetailsURLString(for albumId: String) -> String {
        "\(baseURLString)/\(albumId)/children"
    }
    // Access token is stored in Configuration(XCConfig) files as we should not hard code them in the code
    
    var accessToken: String {
        guard
            let accessToken: String = Bundle.fetchValue(for: Constants.accessToken),
            !accessToken.isEmpty
        else {
            fatalError(Constants.fatalErrorMessage.localized)
        }
        
        return accessToken
    }
}
