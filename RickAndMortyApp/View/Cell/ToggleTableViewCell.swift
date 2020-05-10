//
//  ToggleTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 06/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit

class ToggleTableViewCell: UITableViewCell {
    
    enum State {
        case on
        case off
    }
    
    static let defaultReuseIdentifier = "DefaultReuseIdentifier"
    static let subtitleReuseIdentifier = "SubtitleReuseIdentifier"
    
    var state: State = .off {
        didSet {
            self.imageView?.image = state == .on ? #imageLiteral(resourceName: "cell_toggle_on") : #imageLiteral(resourceName: "cell_toggle_off")
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(
            style: reuseIdentifier == ToggleTableViewCell.subtitleReuseIdentifier
                ? .subtitle : .default,
            reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.imageView?.image = #imageLiteral(resourceName: "cell_toggle_off")
        self.selectionStyle = .none
        if reuseIdentifier == ToggleTableViewCell.defaultReuseIdentifier {
            self.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
            self.textLabel?.textColor = .defaultRowTitle
        } else if reuseIdentifier == ToggleTableViewCell.subtitleReuseIdentifier {
            self.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            self.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            self.textLabel?.textColor = .rowTitle
            self.detailTextLabel?.textColor = .rowSubtitle
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("What the fuck are you doing?!")
    }
    
    override func prepareForReuse() {
        self.imageView?.image = #imageLiteral(resourceName: "cell_toggle_off")
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
    }
}
