//
//  FeedImageDataCache.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/10/11.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)

}
