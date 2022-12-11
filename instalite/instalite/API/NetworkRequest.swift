//
//  NetworkRequest.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

typealias Headers = [String: String]
typealias QueryParams = [String: String]

struct NetworkRequest {
    // MARK: Properties
    
    let url: String
    let headers: Headers?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod
    let queryParams: QueryParams?
    
    // MARK: Init
    
    init(
        url: String,
        headers: Headers? = nil,
        body: Data? = nil,
        requestTimeOut: Float? = nil,
        httpMethod: HTTPMethod,
        queryParams: QueryParams? = nil
    ) {
        self.url = url
        self.headers = headers
        self.body = body
        self.requestTimeOut = requestTimeOut
        self.httpMethod = httpMethod
        self.queryParams = queryParams
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        
        let finalURL = url.appending(queryParams: queryParams)
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        
        return urlRequest
    }
}
