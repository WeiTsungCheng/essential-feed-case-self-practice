//
//  FeedImageViewModel.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/6.
//


import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}

