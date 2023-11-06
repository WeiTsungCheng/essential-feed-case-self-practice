//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/8.
//

import EssentialFeedStudy

class FeedLoaderStub: FeedLoader {
    
    private let result: FeedLoader.Result
    
    init(result: FeedLoader.Result) {
        self.result = result
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        
        completion(result)
    }
    
}
