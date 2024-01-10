//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/9.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    
    public func insert(_ data: Data, for url: URL) throws {
        
        try performSync { context in
            Result {
                try ManagedFeedImage.first(with: url, in: context)
                    .map { $0.data = data }
                    .map(context.save)
            }
        }
        
    }
    
    public func retrieve(dataForURL url: URL) throws -> Data? {
       
        return try performSync { context in
            Result {
                try ManagedFeedImage.data(with: url, in: context)
            }
        }
        
    }
    
}
