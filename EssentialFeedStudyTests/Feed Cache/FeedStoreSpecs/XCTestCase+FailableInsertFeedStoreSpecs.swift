//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/11.
//

import XCTest
import EssentialFeedStudy

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    
    func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert((uniqueImageFeed().local, Date()), to: sut)
        
        expect(sut, toRetrieve: .success(.empty), file: file, line: line)
    }
    
}
