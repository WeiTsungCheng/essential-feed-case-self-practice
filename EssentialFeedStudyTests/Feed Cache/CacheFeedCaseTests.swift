//
//  CacheFeedCaseTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/7/25.
//

import XCTest

class LoadFeedLoader {
    init(store: FeedStore) {
        
    }
}


class FeedStore {
    var deleteCachedFeedCallCount = 0
}

final class CacheFeedCaseTests: XCTestCase {
 
    func test_init_doesNotDeleteCacheUponCreation() {
        
        let store = FeedStore()
        let _ = LoadFeedLoader(store: store)
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }

}
