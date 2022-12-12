//
//  MediaDetailView.swift
//  instalite
//
//  Created by Veera on 11/12/22.
//

import SwiftUI

struct MediaDetailView: View {
    private struct Constants{
        static let placeHolderImage = "photo"
        static let loading = "loading"
    }
    
    @ObservedObject var viewModel: MediaDetailViewModel
    
    var body: some View {
        contentView()
    }
    
    @ViewBuilder
    func contentView() -> some View {
        switch (viewModel.currentState) {
        case .idle:
            idleView()
        case .loading:
            pageLoadingView()
                .padding(.top, 16)
        case .failure(let errorMessage):
            errorView(errorMessage: errorMessage)
        case .loaded:
            if let mediaItem = viewModel.mediaItem {
                photoView(mediaItem: mediaItem)
            }
            if let albumInfo = viewModel.albumInfo {
                albumView(albumInfo: albumInfo)
            }
        case .empty:
            emptyResultsView()
        }
    }
    
    @ViewBuilder
    func photoView(mediaItem: MediaItem) -> some View {
        VStack {
            AsyncImage(url: mediaItem.mediaURL.url) { phase in
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
            
            VStack(spacing: 8) {
                Text(mediaItem.caption ?? "")
                Text(mediaItem.timestamp.formattedDateString() ?? "")
            }
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    func albumView(albumInfo: AlbumInfo) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
                ForEach(albumInfo.data, id: \.id) { albumItem in
                    VStack {
                        AsyncImage(url: albumItem.mediaURL.url) { phase in
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
                        Text(albumItem.timestamp.formattedDateString() ?? "")
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
    
    @ViewBuilder
    func idleView() -> some View {
        Text("No image to show")
    }
    @ViewBuilder
    func emptyResultsView() -> some View {
        Text("No images found")
    }
    
    @ViewBuilder
    func pageLoadingView() -> some View {
        VStack {
            LoadingView(loadingText: Constants.loading.localized)
        }
    }
    
    @ViewBuilder
    func errorView(errorMessage: String) -> some View {
        Text(errorMessage)
    }
}
