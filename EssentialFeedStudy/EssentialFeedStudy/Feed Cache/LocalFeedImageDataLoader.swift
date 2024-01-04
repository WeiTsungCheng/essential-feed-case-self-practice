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
        store.retrieve(dataForURL: url) { [weak self] result in
            
            guard self != nil else { return }
            
            task.complete(with: result
                .mapError{ _ in LoadError.failed}
                .flatMap{ data in
                    data.map { .success($0) } ?? .failure(LoadError.notFound)
                })
        }
        
        return task
    }
    
}

extension LocalFeedImageDataLoader: FeedImageDataCache {
    public typealias SaveResult = FeedImageDataCache.Result
    
    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void) {
    
        completion(SaveResult(catching: {
            try store.insert(data, for: url)
        }).mapError { _ in SaveError.failed})

    }
}
