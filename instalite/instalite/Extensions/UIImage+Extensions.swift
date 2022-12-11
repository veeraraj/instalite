//
//  UIImage+Extensions.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import SwiftUI

extension UIImage {
    var swiftUIImage: SwiftUI.Image {
        SwiftUI.Image(uiImage: self)
    }
}
