//
//  FeedEndpointTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/12/4.
//

import XCTest
import EssentialFeedStudy

class FeedEndpointTests: XCTestCase {

    func test_feed_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = FeedEndpoint.get.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v1/feed")!
        
        XCTAssertEqual(received, expected)
    }

}
