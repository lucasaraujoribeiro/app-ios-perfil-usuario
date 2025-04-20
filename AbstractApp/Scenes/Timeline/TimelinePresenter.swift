//
//  TimelinePresenter.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation

class TimelinePresenter {
    private weak var viewController: TimelineViewController?
    private let router: TimelineRouter
    
    init(viewController: TimelineViewController?, router: TimelineRouter) {
        self.viewController = viewController
        self.router = router
    }
}

extension TimelinePresenter {
    func startLoading() {
        viewController?.displayLoading()
    }
    
    func presentTimeline(with posts: [Post]) {
        viewController?.displayTimeline(with: posts)
    }
}
