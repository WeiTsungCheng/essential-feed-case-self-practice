//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by WEI-TSUNG CHENG on 2023/12/2.
//

import UIKit
import Combine
import EssentialFeedStudy
import EssentailFeediOS

public final class CommentsUIComposer {
    
    private init() {}
    
    private typealias CommentPresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>
    
    
    public static func commentsComposedWith(commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>) -> ListViewController {
        let presentationAdapter = CommentPresentationAdapter(loader: commentsLoader)
        
        let feedController = makeCommentsViewController(title: ImageCommentsPresenter.title)
        feedController.onRefresh = presentationAdapter.loadResource
        
        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: CommentsViewAdapter(
                controller: feedController),
            loadingView: WeakRefVirtualProxy(feedController),
            errorView: WeakRefVirtualProxy(feedController),
            mapper: { ImageCommentsPresenter.map($0) })
        
        return feedController
    }
    
    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        
        return controller
    }
}

