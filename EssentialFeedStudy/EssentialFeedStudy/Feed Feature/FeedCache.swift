//
//  FeedCache.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/10/8.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
