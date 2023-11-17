//
//  FeedLoaderPresentationAdapter.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/31.
//

import Combine
import EssentialFeedStudy
import EssentailFeediOS

internal final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {

    private let feedLoader: () -> AnyPublisher<[FeedImage], Error>
    private var cancellable: Cancellable?
    var presenter: FeedPresenter?
    
    init(feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        cancellable = feedLoader()
            .dispatchOnMainQueue()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self?.presenter?.didFinishLoadingFeed(with: error)
                }
                
            } receiveValue: { [weak self] feed in
                self?.presenter?.didFinishLoadingFeed(with: feed)
            }
        
    }
    
}
