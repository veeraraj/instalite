//
//  UIViewController+Extensions.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import UIKit

enum DefaultAlert: String {
    case title = "defaultAlertTitle"
    case cancel = "defaultAlertCancel"
    case ok = "defaultAlertOk"
}

enum AlertAction: Int {
    case ok
    case cancel
    
}

extension UIViewController {
    func showAlertWithCancelAction(_ title: String = DefaultAlert.title.rawValue,
                                   message: String,
                                   completion: @escaping (AlertAction) -> Void) {
        let alert = UIAlertController(title: DefaultAlert.title.rawValue.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DefaultAlert.ok.rawValue.localized, style: .default, handler: { _ in completion(AlertAction.ok) }))
        alert.addAction(UIAlertAction(title: DefaultAlert.cancel.rawValue.localized, style: .default, handler: { _ in completion(AlertAction.cancel) }))
        
        self.present(alert, animated: true)
    }
    
    func showInfoAlert(_ title: String = DefaultAlert.title.rawValue.localized, message: String) {
        let alert = UIAlertController(title: DefaultAlert.title.rawValue.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: DefaultAlert.ok.rawValue.localized, style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
