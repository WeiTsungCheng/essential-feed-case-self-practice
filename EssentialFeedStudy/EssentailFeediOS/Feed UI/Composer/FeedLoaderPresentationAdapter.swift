//
//  FeedLoaderPresentationAdapter.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/31.
//

import EssentialFeedStudy

internal final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    
    private let feedLoader: FeedLoader
    
    var presenter: FeedPresenter?
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        feedLoader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.presenter?.didFinishLoadingFeed(with: feed)
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
    
}

