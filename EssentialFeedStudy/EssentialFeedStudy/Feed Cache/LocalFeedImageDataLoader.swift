//
//  LocalFeedImageDataLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/8.
//

import Foundation

public final class LocalFeedImageDataLoader: FeedImageDataLoader {
    
    private let store: FeedImageDataStore
    
    public init(store: FeedImageDataStore) {
        self.store = store
    }
}

extension LocalFeedImageDataLoader: FeedImageDataCache {
  
    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL) throws {
        do {
            try store.insert(data, for: url)
        } catch {
            throw SaveError.failed
        }
        
    }
}


extension LocalFeedImageDataLoader {
    
    public enum LoadError: Swift.Error {
        case failed
        case notFound
    }
    
    private final class LoadImageDataTask: FeedImageDataLoaderTask {
        private var completion: ((FeedImageDataLoader.Result) -> Void)?
        
        public init(_ completion: (@escaping (FeedImageDataLoader.Result) -> Void)) {
            self.completion = completion
        }
        
        public func complete(with result: FeedImageDataLoader.Result) {
            completion?(result)
        }
        
        public func cancel() {
            preventFurtherCompletion()
        }
        
        private func preventFurtherCompletion() {
            completion = nil
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeedStudy.FeedImageDataLoaderTask {
        
        let task = LoadImageDataTask(completion)
        
        task.complete(with: Swift.Result {
                try store.retrieve(dataForURL: url)
            }
            .mapError{ _ in LoadError.failed}
            .flatMap{ data in
                data.map { .success($0) } ?? .failure(LoadError.notFound)
            })
        
        return task
    }
    
}

