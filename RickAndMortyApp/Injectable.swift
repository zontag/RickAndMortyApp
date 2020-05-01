//
//  ViewCoding.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

protocol Injectable {
    
    func inject(_ container: Container)
}

extension Injectable where Self: UIViewController {
    
    init(_ container: Container) {
        self.init(nibName: nil, bundle: nil)
        self.inject(container)
    }
}
