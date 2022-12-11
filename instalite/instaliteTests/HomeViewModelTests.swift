//
//  HomeViewModelTests.swift
//  instaliteTests
//
//  Created by Veera on 11/12/22.
//

import XCTest
import SwiftyMocky
@testable import instalite

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var accountService: AccountRepositoryProtocolMock!
    private var mediaService: MediaRepositoryProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        accountService = AccountRepositoryProtocolMock()
        mediaService = MediaRepositoryProtocolMock()
        viewModel = HomeViewModel(accountInfoRepository: accountService, mediaInfoRepository: mediaService)
    }
    
    override func tearDown() {
        viewModel = nil
        accountService = nil
        mediaService = nil
        
        super.tearDown()
    }
    
    func test_account_and_media_info() {
        accountService.given(.fetchAccountInfo(willReturn: mockAccountInfoAvailable()))
        mediaService.given(.fetchMediaInfo(willReturn: mockMediaInfo()))
        
        viewModel.viewDidLoad()
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            XCTAssertEqual(self?.viewModel.accountInfo?.id, "123")
            XCTAssertEqual(self?.viewModel.accountInfo?.username, "po")
            XCTAssertEqual(self?.viewModel.accountInfo?.media_count, 2)
            
            XCTAssertEqual(self?.viewModel.mediaInfo?.data.count, 1)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func test_account_info_unavailable() {
        accountService.given(.fetchAccountInfo(willReturn: mockAccountInfoUnavailable()))
        
        viewModel.viewDidLoad()
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            XCTAssertEqual(self?.viewModel.error?.localizedDescription, "unknown")
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
}

private extension HomeViewModelTests {
    func mockAccountInfoAvailable() -> AccountInfo {
        AccountInfo(id: "123", username: "po", media_count: 2)
    }
    
    func mockAccountInfoUnavailable() -> AccountInfo {
        AccountInfo(id: "", username: "po", media_count: 2)
    }
    
    func mockMediaInfo() -> MediaInfo {
        MediaInfo(data: [MediaItem(id: "789", mediaType: "IMAGE", timestamp: "12/12/2022", mediaURL: "https://hello", caption: "hola")])
    }
}
