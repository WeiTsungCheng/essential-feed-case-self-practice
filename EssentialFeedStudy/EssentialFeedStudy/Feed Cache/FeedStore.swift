//
//  FeedStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/29.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    func retrieve() throws -> CachedFeed?
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
    func deleteCachedFeed() throws
    
}



