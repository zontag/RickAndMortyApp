//
//  ViewCoding.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

protocol ViewCoding: UIViewController {

    init(_ container: Container)
    
    func inject(_ container: Container)
}

extension ViewCoding {
    
    init(_ container: Container) {
        self.init(nibName: nil, bundle: nil)
        self.inject(container)
    }
}
