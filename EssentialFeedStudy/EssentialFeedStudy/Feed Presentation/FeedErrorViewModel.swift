//
//  FeedErrorViewModel.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/4.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
