//
//  MediaDetailsViewModelTests.swift
//  instaliteTests
//
//  Created by Veera on 11/12/22.
//

import XCTest
import SwiftyMocky
@testable import instalite

final class MediaDetailsViewModelTests: XCTestCase {
    
    private var viewModel: MediaDetailViewModel!
    private var mediaService: MediaRepositoryProtocolMock!
    
    // MARK: Setup
    
    override func setUp() {
        super.setUp()
        
        mediaService = MediaRepositoryProtocolMock()
    }
    
    override func tearDown() {
        viewModel = nil
        mediaService = nil
        
        super.tearDown()
    }
    
    // MARK: Tests
    
    @MainActor
    func test_photo_media_details() {
        viewModel = MediaDetailViewModel(selectedMediaItem: mockPhotoMediaDetails(), mediaInfoRepository: mediaService)
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            XCTAssertEqual(self?.viewModel.mediaItem?.id, "1234")
            XCTAssertEqual(self?.viewModel.mediaItem?.mediaType, "IMAGE")
            XCTAssertNil(self?.viewModel.albumInfo)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    @MainActor
    func test_album_media_details() {
        viewModel = MediaDetailViewModel(selectedMediaItem: mockAlbumMediaDetails(), mediaInfoRepository: mediaService)
        mediaService.given(.fetchAlbumInfo(for: "3454", willReturn: mockAlbumInfo()))
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            XCTAssertNil(self?.viewModel.mediaItem)
            XCTAssertEqual(self?.viewModel.albumInfo?.data.count, 3)
            XCTAssertEqual(self?.viewModel.albumInfo?.data.first?.id, "1234")
            XCTAssertEqual(self?.viewModel.albumInfo?.data.last?.id, "90102")
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    @MainActor
    func test_album_empty_results() {
        viewModel = MediaDetailViewModel(selectedMediaItem: mockAlbumMediaDetails(), mediaInfoRepository: mediaService)
        mediaService.given(.fetchAlbumInfo(for: "3454", willReturn: mockEmptyAlbumInfo()))
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            XCTAssertNil(self?.viewModel.mediaItem)
            XCTAssertEqual(self?.viewModel.albumInfo?.data.count, 0)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
}

// MARK: Mock

private extension MediaDetailsViewModelTests {
    func mockPhotoMediaDetails() -> MediaItem {
        MediaItem(id: "1234", mediaType: "IMAGE", timestamp: "122212255", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ANo9K5cEAAAA&oh=00_AfCK2dMK_xVNl8z1aITiUPkPBHE0h9ZnvHA8VCTowFPt8A&oe=6399C211", caption: "tryout")
    }
    
    func mockAlbumMediaDetails() -> MediaItem {
        MediaItem(id: "3454", mediaType: "CAROUSEL_ALBUM", timestamp: "122212255", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ANo9K5cEAAAA&oh=00_AfCK2dMK_xVNl8z1aITiUPkPBHE0h9ZnvHA8VCTowFPt8A&oe=6399C211", caption: "tryout")
    }
    
    func mockAlbumInfo() -> AlbumInfo {
        AlbumInfo(data: [
            AlbumItem(id: "1234", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211"),
            AlbumItem(id: "5678", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211"),
            AlbumItem(id: "90102", mediaType: "Image", timestamp: "2020-07-15T17:56:38+0000", mediaURL: "https://scontent-ams2-1.cdninstagram.com/v/t51.29350-15/108010177_117239056498045_3069756398166799087_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=8ae9d6&_nc_ohc=XkwI4jCE4wAAX-F5gZo&_nc_ht=scontent-ams2-1.cdninstagram.com&edm=ABbrh9MEAAAA&oh=00_AfDBpsjfjcsMql4Ebq36ZbZ39mX91WlWK0d0ogdVLlQZ1g&oe=6399C211")
        ])
    }
    
    func mockEmptyAlbumInfo() -> AlbumInfo {
        AlbumInfo(data: [])
    }
}
