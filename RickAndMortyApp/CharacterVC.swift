//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit

class CharacterVC: UIViewController, Injectable {
    
    var charactersView = CharacterView()
    var text: String!
    
    func inject(_ container: Container) {
        self.text = container()
    }
    
    override func loadView() {
        self.view = charactersView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
