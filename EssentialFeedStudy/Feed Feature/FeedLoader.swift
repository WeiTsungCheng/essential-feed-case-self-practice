//
//  FeedLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/9.
//

import Foundation

public enum LoadFeedResult <Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
    
}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
