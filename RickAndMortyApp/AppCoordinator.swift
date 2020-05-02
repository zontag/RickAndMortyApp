//
//  AppCoordinator.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UITabBarController
    let tabBarCoordinator: TabBarCoordinator
    
    init(window: UIWindow) { //4
        self.window = window
        rootViewController = UITabBarController()
        self.tabBarCoordinator = TabBarCoordinator(tabBarController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        tabBarCoordinator.start()
        window.makeKeyAndVisible()
    }
}
