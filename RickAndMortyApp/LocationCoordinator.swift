//
//  LocationCoordinator.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 02/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

class LocationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var locationVC: UIViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let locationVC = UIViewController()
        locationVC.title = "Location"
        let button = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterAction))
            .plainStyle()
        locationVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(locationVC, animated: true)
        self.locationVC = locationVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
