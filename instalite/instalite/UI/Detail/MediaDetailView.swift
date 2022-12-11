//
//  MediaDetailView.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import SwiftUI

struct MediaDetailView: View {
    private enum Constants: String {
        static let placeHolderImage = "photo"
        case loading = "Loading"
    }
    
    @ObservedObject var viewModel: MediaDetailViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(viewModel.mediaURLStrings, id: \.self) { image in
                    AsyncImage(url: image.url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
                                .aspectRatio(contentMode: .fill)
                            
                        case .failure:
                            if let image = UIImage(named: Constants.placeHolderImage) {
                                image.swiftUIImage
                                    .resizable()
                                    .frame(minWidth: 100, maxWidth: 250, minHeight: 100, maxHeight: 250)
                                    .aspectRatio(contentMode: .fill)
                            }
                        case .empty:
                            imageLoadingView()
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func imageLoadingView() -> some View {
        VStack {
            LoadingView(loadingText: "")
        }
    }
}


extension UIImage {
    var swiftUIImage: SwiftUI.Image {
        SwiftUI.Image(uiImage: self)
    }
}

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

//struct MediaDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaDetailView()
//    }
//}
