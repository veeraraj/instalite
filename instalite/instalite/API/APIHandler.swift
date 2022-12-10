//
//  APIHandler.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

protocol NetworkRequestProtocol {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ request: NetworkRequest) async throws -> T
}

class APIHandler: NetworkRequestProtocol {
    
    // MARK: Properties
    
    let networkHandler: URLSession
    var requestTimeOut: Float = 30
        
    // MARK: Init
    
    init(networkHandler: URLSession = URLSession.shared) {
        self.networkHandler = networkHandler
    }
    
    // MARK: Public methods
    
    func request<T>(_ request: NetworkRequest) async throws-> T
    where T: Decodable, T: Encodable {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        
        guard let urlRequest = request.urlRequest else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await networkHandler.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.noResponse }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.unableToParseData
            }
        default:
            throw NetworkError.error(for: httpResponse.statusCode)
        }
    }
}
