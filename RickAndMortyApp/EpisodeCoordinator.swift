//
//  EpisodeCoordinator.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 02/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

class EpisodeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var episodeVC: UIViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let episodeVC = UIViewController()
        episodeVC.title = "Episode"
        let button = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterAction))
            .plainStyle()
        episodeVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(episodeVC, animated: true)
        self.episodeVC = episodeVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
