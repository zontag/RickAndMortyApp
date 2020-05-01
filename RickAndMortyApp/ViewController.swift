//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewCoding {
    
    var text: String!
    
    func inject(_ container: Container) {
        self.text = container()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.text = text
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.textColor = .black
    }
}
