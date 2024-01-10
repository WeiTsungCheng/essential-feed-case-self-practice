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
    
    func insert(_ feed: [EssentialFeedStudy.LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(.none))
    }
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        completion(.success(()))
    }
    
}

extension NullStore: FeedImageDataStore {
    
    func insert(_ data: Data, for url: URL) throws {}
    
    func retrieve(dataForURL url: URL) throws -> Data? { .none }

}
