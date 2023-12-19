//
//  CommentsViewAdapter.swift
//  EssentialApp
//
//  Created by WEI-TSUNG CHENG on 2023/12/14.
//

import UIKit
import Combine
import EssentialFeedStudy
import EssentailFeediOS

final class CommentsViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: ImageCommentsViewModel) {
        controller?.display(viewModel.comments.map({ viewModel in
            CellController(id: viewModel, ImageCommentCellController(model: viewModel))
        }))
    }
}
