//
//  FeedCache.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/10/8.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
