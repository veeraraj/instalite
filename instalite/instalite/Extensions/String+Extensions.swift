//
//  String+Extensions.swift
//  instalite
//
//  Created by Veera on 10/12/22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self)_comment")
    }
}
