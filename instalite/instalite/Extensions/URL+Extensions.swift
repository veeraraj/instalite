//
//  URL+Extensions.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

extension URL {
    func appending(path: String) -> URL {
        appendingPathComponent(path, isDirectory: false)
    }
    
    func appending(queryParams: [String: String]?) -> URL {
        guard let queryParams = queryParams else { return self }
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        components.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        return components.url!
    }
}
