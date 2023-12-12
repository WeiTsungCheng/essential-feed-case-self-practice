//
//  FeedPresenter.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/4.
//

import Foundation

public final class FeedPresenter {
    public static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Title for the feed view")
    }

}
