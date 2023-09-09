//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/9.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    public func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
       
        perform { context in
            completion(Result {
                return try ManagedFeedImage.first(with: url, in: context)?.data
            })
        }
    }
    
    public func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void) {
        
        perform { context in
            guard let image = try? ManagedFeedImage.first(with: url, in: context) else { return }
            image.data = data
            try? context.save()
        }

    }
    
}
