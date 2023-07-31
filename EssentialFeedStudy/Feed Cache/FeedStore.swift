//
//  FeedStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/29.
//

import Foundation

public protocol FeedStore {
    
    typealias DeleteCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrieveCompletion = (Error?) -> Void
    
    func deleteCachedFeed(completion: @escaping DeleteCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrieveCompletion) 
    
}


