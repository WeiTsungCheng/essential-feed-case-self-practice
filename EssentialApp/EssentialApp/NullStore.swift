//
//  NullStore.swift
//  EssentialApp
//
//  Created by WEI-TSUNG CHENG on 2023/12/20.
//

import Foundation
import EssentialFeedStudy

class NullStore {}

extension NullStore: FeedStore {
    
    func insert(_ feed: [EssentialFeedStudy.LocalFeedImage], timestamp: Date) throws {}
    
    func retrieve() throws -> CachedFeed? { .none }
    
    func deleteCachedFeed() throws {}
    
}

extension NullStore: FeedImageDataStore {
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) throws -> Data? { .none }

}
