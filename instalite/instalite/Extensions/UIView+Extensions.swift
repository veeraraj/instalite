//
//  UIView+Extensions.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import UIKit

extension UIView {
    func pinToSuperviewEdges() {
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
    
    func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
