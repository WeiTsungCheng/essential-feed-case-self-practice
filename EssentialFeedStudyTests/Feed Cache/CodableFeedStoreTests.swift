//
//  CodableFeedStoreTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/7.
//

import XCTest
import EssentialFeedStudy

class CodableFeedStore {
    
    func retrieve(completion: @escaping FeedStore.RetrieveCompletion) {
        
        completion(.empty)
    }
}

final class CodableFeedStoreTests: XCTestCase {

    func test_retrieve_deliverEmptyOnEmptyCache() {
        let sut = CodableFeedStore()
        let exp = expectation(description: "wait for cache retrieval")
    
        sut.retrieve { result in
            switch result  {
            case .empty:
                break
                
            default:
                XCTFail("Expected empty result, got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        
        let sut = CodableFeedStore()
        let exp = expectation(description: "wait for cache retrieval")
        
        sut.retrieve { firstResult in
            
            sut.retrieve { secondResult in
                switch (firstResult, secondResult)  {
                case (.empty, .empty):
                    break
                    
                default:
                    XCTFail("Expected empty result, got \(firstResult) and \(secondResult) instead")
                }
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1.0)
      
    }

}
