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
    
    var url: URL? {
        URL(string: self)
    }
    
    func formattedDateString() -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}
