//
//  FeedImagePresenter.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/6.
//

import Foundation

public final class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location
        )
    }
}
