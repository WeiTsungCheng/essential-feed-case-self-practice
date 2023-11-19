//
//  FeedViewControllerTests+Localization.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/31.
//

import XCTest
import EssentialFeedStudy
import EssentailFeediOS

extension FeedUIIntegrationTests {
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }
    
    var loadError: String {
        return LoadResourcePresenter<Any, DummyView>.loadError
    }
    
    var feedTitle: String {
        return FeedPresenter.title
    }
}
