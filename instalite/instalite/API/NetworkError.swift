//
//  NetworkError.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case badURL
    case noResponse
    case unableToParseData
    case apiError
    case unauthorized
    case requestFailed
    case serverError
    case unknown
    
    static func error(for code: Int) -> NetworkError {
        switch code {
        case 400...499:
            return NetworkError.requestFailed
        case 500...599:
            return NetworkError.serverError
        default:
            return NetworkError.unknown
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return "badUrl".localized
        case .noResponse:
            return "noResponse".localized
        case .unableToParseData:
            return "unable to parse data".localized
        case .apiError:
            return "api error".localized
        case .unauthorized:
            return "unauthorized".localized
        case .requestFailed:
            return "request failed".localized
        case .serverError:
            return "server error".localized
        case .unknown:
            return "unknown".localized
        }
    }
}
