//
//  UIBarButtonItem+Extensions.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func plainStyle() -> UIBarButtonItem {
        self.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ], for: .normal)
        self.tintColor = .primary
        return self
    }
}
