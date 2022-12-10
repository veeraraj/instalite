//
//  Bundle+Extensions.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

extension Bundle {
    static func fetchValue<T>(for key: String) -> T? {
        main.infoDictionary?[key] as? T
    }
}
