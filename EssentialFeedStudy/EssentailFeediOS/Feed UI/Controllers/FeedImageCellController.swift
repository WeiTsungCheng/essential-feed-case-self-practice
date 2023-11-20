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

public final class FeedImageCellController: FeedImageView, ResourceView, ResourceLoadingView, ResourceErrorView {
    
    public typealias ResourceViewModel = UIImage
    
    private let viewModel: FeedImageViewModel<UIImage>
    private let delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(viewModel: FeedImageViewModel<UIImage>, delegate: FeedImageCellControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        
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

    func preload() {
        delegate.didRequestImage()
    }
    
    func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    public func display(_ viewModel: FeedImageViewModel<UIImage>) {}
    
    public func display(_ viewModel: UIImage) {
        cell?.feedImageView.setImageAnimated(viewModel)
    }
    
    public func display(_ viewModel: EssentialFeedStudy.ResourceLoadingViewModel) {
        cell?.feedImageContainer.isShimmering = viewModel.isLoading
    }
    
    public func display(_ viewModel: EssentialFeedStudy.ResourceErrorViewModel) {
        cell?.feedImageRetryButton.isHidden = viewModel.message == nil
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
    
}
