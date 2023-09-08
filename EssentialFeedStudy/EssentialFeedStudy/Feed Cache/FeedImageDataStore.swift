//
//  FeedImageDataStore.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/8.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
