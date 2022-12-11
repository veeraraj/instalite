//
//  MediaDetailViewModel.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import Foundation
import Combine

final class MediaDetailViewModel: ObservableObject {
    @Published private(set) var mediaURLStrings: [String]
    
    init(mediaURLStrings: [String]) {
        self.mediaURLStrings = mediaURLStrings
    }
}
