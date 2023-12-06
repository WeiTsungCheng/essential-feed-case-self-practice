//
//  LoadMoreCellController.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/12/6.
//

import UIKit
import EssentialFeedStudy

public class LoadMoreCellController: NSObject, UITableViewDataSource {
    private let cell = LoadMoreCell()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell
    }
}

extension LoadMoreCellController: ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell.isLoading = viewModel.isLoading
    }
    
    public func display(_ viewModel: EssentialFeedStudy.ResourceErrorViewModel) {
        cell.message = viewModel.message
    }
}

