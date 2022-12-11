//
//  UIColor+Extensions.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import UIKit

extension UIColor {
    static func theme(_ name: AssetColors) -> UIColor {
        return UIColor(named: name.rawValue) ?? .white
    }
}
