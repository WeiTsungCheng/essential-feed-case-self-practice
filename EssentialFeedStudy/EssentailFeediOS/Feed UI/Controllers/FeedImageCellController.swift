//
//  FeedImageCellController.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit
import EssentialFeedStudy

public protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedImageCellController: NSObject, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    public typealias ResourceViewModel = UIImage
    
    private let viewModel: FeedImageViewModel
    private let delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(viewModel: FeedImageViewModel, delegate: FeedImageCellControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.locationContainer.isHidden = !viewModel.hasLocation
        cell?.locationLabel.text = viewModel.location
        cell?.descriptionLabel.text = viewModel.description
        cell?.onRetry = delegate.didRequestImage
        cell?.onReuse = { [weak self] in
            self?.releaseCellForReuse()
        }
        delegate.didRequestImage()
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        cancelLoad()
    }
    
    public func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
}


extension FeedImageCellController: ResourceView, ResourceLoadingView, ResourceErrorView {
    
    public func display(_ viewModel: UIImage) {
        cell?.feedImageView.setImageAnimated(viewModel)
    }
    
    public func display(_ viewModel: EssentialFeedStudy.ResourceLoadingViewModel) {
        cell?.feedImageContainer.isShimmering = viewModel.isLoading
    }
    
    public func display(_ viewModel: EssentialFeedStudy.ResourceErrorViewModel) {
        cell?.feedImageRetryButton.isHidden = viewModel.message == nil
    }
    
}
