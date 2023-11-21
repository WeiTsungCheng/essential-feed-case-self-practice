//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/9/14.
//

import XCTest


extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
        
    }
}
