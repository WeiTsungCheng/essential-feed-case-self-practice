//
//  ListViewController+TestHelpers.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit
import EssentailFeediOS

extension ListViewController {
    // 把 tableview 的 frame 設的超級小 讓 image 不會在ㄧ開始時就被 load, 直到呼叫它的方法
    public override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        
        tableView.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
    func simulateUserInitiatedReload() {
        refreshControl?.simulatePullToRefresh()
    }
    
    func simulateTapOnLoadMoreFeedError() {
        let delegate = tableView.delegate
        let index = IndexPath(row: 0, section: feedLoadMoreSection)
        delegate?.tableView?(tableView, didSelectRowAt: index)
    }
    
    var isShowingLoadingIndicator: Bool {
        return refreshControl?.isRefreshing == true
    }
    
    func simulateErrorViewTap() {
        errorView.simulateTap()
    }
    
    var errorMessage: String? {
        return errorView.message
    }
    
    func numberOfRows(in section: Int) -> Int {
        tableView.numberOfSections > section ? tableView.numberOfRows(inSection: section) : 0
    }
    
    func cell(row: Int, section: Int) -> UITableViewCell? {
        guard numberOfRows(in: section) > row else {
            return nil
        }
    
        let ds = tableView.dataSource
        let index = IndexPath(row: row, section: section)
        return ds?.tableView(tableView, cellForRowAt: index)
    }

}

extension ListViewController {
    func numberOfRenderedComments() -> Int {
        numberOfRows(in: commentsSection)
    }
    
    func commentMessage(at row: Int) -> String? {
        commentView(at: row)?.messageLabel.text
    }
    
    func commentDate(at row: Int) -> String? {
        commentView(at: row)?.dateLabel.text
    }
    
    func commentUsername(at row: Int) -> String? {
        commentView(at: row)?.usernameLabel.text
    }
    
    private func commentView(at row: Int) -> ImageCommentCell? {
        cell(row: row, section: commentsSection) as? ImageCommentCell
    }
    
    private var commentsSection: Int { 0 }
    
}

extension ListViewController {
    
    @discardableResult
    func simulateFeedImageViewVisible(at index: Int) -> FeedImageCell? {
        return feedImageView(at: index) as? FeedImageCell
    }
    
    @discardableResult
    func simulateFeedImageBecomingVisibleAgain(at row: Int) -> FeedImageCell? {
        let view = simulateFeedImageViewVisible(at: row)
        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, willDisplay: view!, forRowAt: index)
        
        return view
    }
    
    func simulateTapOnFeedImage(at row: Int) {
        
        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didSelectRowAt: index)
    }
    
    @discardableResult
    func simulateFeedImageViewNotVisible(at row: Int) -> FeedImageCell? {
        let view = simulateFeedImageViewVisible(at: row)
        
        let delegate = tableView.delegate
        let index = IndexPath(row: row, section: feedImagesSection)
        delegate?.tableView?(tableView, didEndDisplaying: view!, forRowAt: index)
        
        return view
    }
    
    func simulateFeedImageViewNearVisible(at row: Int) {
        let ds = tableView.prefetchDataSource
        let index = IndexPath(row: row, section: feedImagesSection)
        ds?.tableView(tableView, prefetchRowsAt: [index])

    }
    
    func simulateFeedImageViewNotNearVisible(at row: Int) {
        simulateFeedImageViewNearVisible(at: row)
        
        let ds = tableView.prefetchDataSource
        let index = IndexPath(row: row, section: feedImagesSection)
        ds?.tableView?(tableView, cancelPrefetchingForRowsAt: [index])

    }
    
    func simulateLoadMoreFeedAction() {
        guard let view = loadMoreFeedCell() else { return }
        
        let delegate = tableView.delegate
        let index = IndexPath(row: 0, section: feedLoadMoreSection)
        delegate?.tableView?(tableView, willDisplay: view, forRowAt: index)
    }
    
    var loadMoreFeedErrorMessage: String? {
        return loadMoreFeedCell()?.message
    }
    
    var canLoadMoreFeed: Bool {
        loadMoreFeedCell() != nil
    }

    var isShowingLoadMoreFeedIndicator: Bool {
        return loadMoreFeedCell()?.isLoading == true
    }
    
    private func loadMoreFeedCell() -> LoadMoreCell? {
        cell(row: 0, section: feedLoadMoreSection) as? LoadMoreCell
    }
    
    func renderedFeedImageData(at index: Int) -> Data? {
        return simulateFeedImageViewVisible(at: index)?.renderedImage
    }
    
    func numberOfRenderedFeedImageViews() -> Int {
        numberOfRows(in: feedImagesSection)
    }
    
    func feedImageView(at row: Int) -> UITableViewCell? {
        cell(row: row, section: feedImagesSection)
    }

    private var feedImagesSection: Int { 0 }
    private var feedLoadMoreSection: Int { 1 }

  
}
