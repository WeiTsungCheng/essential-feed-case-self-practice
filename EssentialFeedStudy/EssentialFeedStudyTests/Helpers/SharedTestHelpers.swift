//
//  SharedTestHelpers.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/5.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
