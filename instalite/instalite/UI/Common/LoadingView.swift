//
//  LoadingView.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    let loadingText: String
    var body: some View {
        loadingView()
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
            
            if !loadingText.isEmpty {
                Text(loadingText)
            }
        }
    }
}
