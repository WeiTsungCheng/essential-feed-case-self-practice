//
//  RemoteFeedItem.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/31.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
