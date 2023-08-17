//
//  FeedStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/29.
//

import Foundation

public enum CachedFeed {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
}

public protocol FeedStore {
    
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias DeletionCompletion = (Error?) -> Void
    
    typealias RetrievalResult = Result<CachedFeed, Error>
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion) 
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
}


