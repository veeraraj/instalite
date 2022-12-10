//
//  AppRepository.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation
import Logging

protocol AppRepositoryProtocol {
    var logger: Logger { get }
    var AccountInfoRepository: AccountRepositoryProtocol { get }
}

final class AppRepository: AppRepositoryProtocol {
    
    static let shared = AppRepository()
    
    private init() {}
    
    lazy var logger: Logger = Logger(label: "com.enablon.instalite")
    lazy var AccountInfoRepository: AccountRepositoryProtocol = AccountRepository(networkRequest: APIHandler(), environment: .development)
}
