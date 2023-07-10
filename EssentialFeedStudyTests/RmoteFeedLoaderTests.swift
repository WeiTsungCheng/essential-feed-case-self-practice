//
//  RmoteFeedLoaderTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/7/9.
//

import XCTest
import Foundation
import EssentialFeedStudy

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {

        let (_, client) = makeSUT()
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!

        let (sut, client) = makeSUT(url: url)
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
        
    }
    
    func test_load_requestDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!

        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requesetedURLs, [url, url])
        XCTAssertEqual(client.requestedURL, url)
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
    
        var requestedURL: URL?
        
        var requesetedURLs = [URL]()
        
        func get(from url: URL) {
             requestedURL = url
            requesetedURLs.append(url)
         }
         
        
    }
}
