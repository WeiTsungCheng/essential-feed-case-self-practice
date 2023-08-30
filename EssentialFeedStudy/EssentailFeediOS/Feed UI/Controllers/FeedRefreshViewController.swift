//
//  FeedRefreshController.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {

   @IBOutlet var view: UIRefreshControl?
    
    var delegate: FeedRefreshViewControllerDelegate?

    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
}
