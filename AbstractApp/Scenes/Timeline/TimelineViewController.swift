//
//  TimelineViewController.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit

class TimelineViewController: UIViewController {
    
    private var interactor: TimelineInteractor?
    private var timelineView: TimelineView = TimelineView()
    
    override func loadView() {
        self.view = timelineView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Timeline"
        initViper()
        timelineView.didSelectCell = { [weak self] in
            let viewController = self?.storyboard?.instantiateViewController(identifier: "postDetail")
            self?.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadTimeline()
    }
    
    private func initViper() {
        let service = TimelineService()
        let router = TimelineRouter(viewController: self)
        let presenter = TimelinePresenter(viewController: self, router: router)
        interactor = TimelineInteractor(service: service, presenter: presenter)
    }
}

extension TimelineViewController {
    func displayLoading() {
        timelineView.startLoading()
    }
    
    func displayTimeline(with posts: [Post]) {
        timelineView.showTimeline(posts)
    }
}
