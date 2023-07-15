//
//  FeedLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/9.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
    
}

protocol FeedLoader {
    
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
