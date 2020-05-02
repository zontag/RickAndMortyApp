//
//  CharactersCoordinator.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

class CharacterCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var charactersVC: CharacterVC?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let charactersVC = CharacterVC(container)
        charactersVC.title = "Character"
        let button = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterAction))
            .plainStyle()
        charactersVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(charactersVC, animated: true)
        self.charactersVC = charactersVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
