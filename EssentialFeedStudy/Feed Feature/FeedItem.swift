//
//  FeedItem.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/9.
//

import Foundation

public struct FeedItem: Equatable {
    
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
