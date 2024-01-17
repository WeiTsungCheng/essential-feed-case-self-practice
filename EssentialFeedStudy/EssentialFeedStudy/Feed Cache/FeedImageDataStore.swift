//
//  FeedImageDataStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/8.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
