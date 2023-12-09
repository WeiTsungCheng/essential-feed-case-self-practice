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
        XCTAssertEqual(received.scheme, "http", "scheme")
        XCTAssertEqual(received.host, "base-url.com", "host")
        XCTAssertEqual(received.path(percentEncoded: true), "/v1/feed", "path")
        XCTAssertEqual(received.query(percentEncoded: true), "limit=10", "query")
    }

}
