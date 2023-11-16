//
//  RemoteFeedLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/10.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedImage]>

public extension RemoteFeedLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: FeedItemsMapper.map)
    }
}
