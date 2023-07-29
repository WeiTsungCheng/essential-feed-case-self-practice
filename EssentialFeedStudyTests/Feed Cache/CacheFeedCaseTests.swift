//
//  CacheFeedCaseTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/7/25.
//

import XCTest
import EssentialFeedStudy

class LocalFeedLoader {
    
    private let store: FeedStore
    private let currentDate: () -> Date
    
    init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items: [FeedItem], completion: @escaping (Error?) -> Void) {
        
        store.deleteCachedFeed { [unowned self] error in
    
            if error == nil {
                self.store.insert(items, timestamp: self.currentDate(), completion: completion)
                
            } else {
                completion(error)
            }
        }
    }
}

protocol FeedStore {
    
    typealias DeleteCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    func deleteCachedFeed(completion: @escaping DeleteCompletion)
    func insert(_ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
    
}


final class CacheFeedCaseTests: XCTestCase {
 
    func test_init_doesNotMessageStoreUponCreation() {
        
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }

    func test_save_requestsCacheDeletion() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items) { _ in }
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        sut.save(items) { _ in }
        store.completeDeletion(with: deletionError)
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed])
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date.init()
        let items = [uniqueItem(), uniqueItem()]
        let (sut, store) = makeSUT { timestamp }
        
        sut.save(items) { _ in }
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedFeed, .insert(items, timestamp)])
    }
    
    func test_save_failsOnDeletionError() {
        
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        expect(sut, toCompletionWithError: deletionError) {
            store.completeDeletion(with: deletionError)
            
        }
    }
    
    
    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSUT()
        let insertionError = anyNSError()
        expect(sut, toCompletionWithError: insertionError) {
                    store.completeDeletionSuccessfully()
                    store.completeInsertion(with: insertionError)
            
        }
    }
    
    func test_save_succeedsOnSuccessfulCacheInsertion() {
        
        let (sut, store) = makeSUT()
        
        expect(sut, toCompletionWithError: nil) {
            
            store.completeDeletionSuccessfully()
            store.completeInsertionSuccessfully()
        }
      
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init , file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    private func expect(_ sut: LocalFeedLoader, toCompletionWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        
        let exp = expectation(description: "Wait for save copletion")
        var receivedError: Error?
        
        sut.save([uniqueItem()]) { error in
            receivedError = error
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError as NSError?, expectedError,  file: #file, line: #line)
        
    }
    
    private class FeedStoreSpy: FeedStore {
        
        enum ReceivedMessage: Equatable {
            case deleteCachedFeed
            case insert([FeedItem], Date)
        }
        
        private(set) var receivedMessages = [ReceivedMessage]()
        private var deletionCompletions = [DeleteCompletion]()
        private var insertionCompletions = [InsertionCompletion]()
        
        func deleteCachedFeed(completion: @escaping DeleteCompletion) {

            deletionCompletions.append(completion)
            receivedMessages.append(.deleteCachedFeed)
        }
        
        func completeDeletion(with error: Error, at index: Int = 0) {
            deletionCompletions[index](error)
        }
        
        func completeDeletionSuccessfully(at index: Int = 0) {
            deletionCompletions[index](nil)
        }
        
        
        func insert(_ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {
            
            insertionCompletions.append(completion)
            receivedMessages.append(.insert(items, timestamp))
        }
        
        func completeInsertion(with error: Error, at index: Int = 0) {
            insertionCompletions[index](error)
        }
        
        func completeInsertionSuccessfully(at index: Int = 0) {
            insertionCompletions[index](nil)
        }
        
       
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(),
                        description: "any",
                        location: "any",
                        imageURL: anyURL())
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
