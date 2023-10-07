//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/8.
//

import XCTest
import EssentialFeedStudy

final class FeedLoaderCacheDecorator: FeedLoader {
    
    private let decorator: FeedLoader
    
    init(decorator: FeedLoader) {
        self.decorator = decorator
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decorator.load(completion: completion)
    }
    
}

class FeedLoaderCacheDecoratorTests: XCTestCase {
    
    func test_load_deliversFeedOnLoaderSuccess() {
        let feed = uniqueFeed()
        let loader = FeedLoaderStub(result: .success(feed))
        let sut = FeedLoaderCacheDecorator(decorator: loader)
        
        expect(sut, toCompleteWith: .success(feed))
    }
    
    func test_load_deliversErrorOnLoaderFailure() {
        let loader = FeedLoaderStub(result: .failure(anyNSError()))
        let sut = FeedLoaderCacheDecorator(decorator: loader)
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }

    
    private func expect(_ sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedFeed), .success(expectedFeed)):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
                
        wait(for: [exp], timeout: 1.0)
    }
    
}
