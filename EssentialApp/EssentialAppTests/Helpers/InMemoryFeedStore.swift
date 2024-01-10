//
//  InMemoryFeedStore.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/15.
//

import Foundation
import EssentialFeedStudy

class InMemoryFeedStore {
    private(set) var feedCache: CachedFeed?
    private var feedImageDataCache: [URL: Data] = [:]
    
    private init(feedCache: CachedFeed? = nil) {
        self.feedCache = feedCache
    }

}


extension InMemoryFeedStore: FeedStore {
    func deleteCachedFeed(completion: @escaping FeedStore.DeletionCompletion) {
        feedCache = nil
        completion(.success(()))
    }
  
    func insert(_ feed: [EssentialFeedStudy.LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
        feedCache = (feed: feed, timestamp: timestamp)
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(feedCache))
    }
}


extension InMemoryFeedStore: FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws {
        feedImageDataCache[url] = data
    }
    
    func retrieve(dataForURL url: URL) throws -> Data? {
        feedImageDataCache[url]
    }
    
}

extension InMemoryFeedStore {
    static var empty: InMemoryFeedStore {
        return InMemoryFeedStore()
    }
    
    static var withExpiredFeedCache: InMemoryFeedStore {
        return InMemoryFeedStore(feedCache: ([], Date.distantPast))
    }
    
    static var withNonExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date()))
    }
    
}
