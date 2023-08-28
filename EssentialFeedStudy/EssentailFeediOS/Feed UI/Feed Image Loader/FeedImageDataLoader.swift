//
//  FeedImageDataLoader.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit
import EssentialFeedStudy

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
