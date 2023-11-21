//
//  ImageCommentsPresenter.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/11/21.
//

import Foundation

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: Self.self),
            comment: "Title for the image comment view"
        )
    }
}
