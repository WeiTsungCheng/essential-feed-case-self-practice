//
//  FeedImageDataStoreSpy.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/9/8.
//

import Foundation
import EssentialFeedStudy

class FeedImageDataStoreSpy: FeedImageDataStore {
 
    enum Message: Equatable {
        case retrieve(dataFor: URL)
        case insert(data: Data, for: URL)
    }

    private(set) var receivedMessages = [Message]()
 
    private var retrievalResult: Result<Data?, Error>?
    private var insertionResult: Result<Void, Error>?
    
    func retrieve(dataForURL url: URL) throws -> Data? {
        receivedMessages.append(.retrieve(dataFor: url))

        return try retrievalResult?.get()
    }
    
    func insert(_ data: Data, for url: URL) throws {
        receivedMessages.append(.insert(data: data, for: url))
        try insertionResult?.get()
    }
    
    func completeRetrieval(with error: Error) {
        retrievalResult = .failure(error)
    }
    
    func completeRetrieval(with data: Data?) {
        retrievalResult = .success(data)
    }
    
    func completionInsertion(with error: Error) {
        insertionResult = .failure(error)
    }
    
    func completeInsertionSuccessfully(index: Int = 0) {
        insertionResult = .success(())
    }
 
    
}

