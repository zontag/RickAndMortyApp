//
//  InfoTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 10/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit
import SnapKit

class InfoTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTableViewCell"
    
    private var vStack: UIStackView!
    private var hStack: UIStackView!
    private var rightIconImageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var detailLabel: UILabel!
    
    var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    var subtitle: String? {
        didSet {
            self.subtitleLabel.text = self.subtitle
        }
    }
    
    var detail: String? {
        didSet {
            self.detailLabel.text = self.detail
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: InfoTableViewCell.identifier)
        
        self.vStack = UIStackView(frame: .zero)
        self.hStack = UIStackView(frame: .zero)
        self.rightIconImageView = UIImageView(frame: .zero)
        self.titleLabel = UILabel(frame: .zero)
        self.subtitleLabel = UILabel(frame: .zero)
        self.detailLabel = UILabel(frame: .zero)
        
        self.vStack.axis = .vertical
        self.hStack.axis = .horizontal
        
        self.titleLabel.numberOfLines = 1
        self.subtitleLabel.numberOfLines = 1
        self.detailLabel.numberOfLines = 1
        
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.detailLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        
        self.titleLabel.textColor = .rowTitle
        self.subtitleLabel.textColor = .rowSubtitle
        self.detailLabel.textColor = .rowDescription
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.vStack.addArrangedSubview(self.titleLabel)
        self.vStack.addArrangedSubview(self.subtitleLabel)
        self.vStack.addArrangedSubview(self.detailLabel)
        self.hStack.addArrangedSubview(self.vStack)
        self.hStack.addArrangedSubview(self.rightIconImageView)
        self.contentView.addSubview(self.hStack)

        self.hStack.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView).offset(16)
            make.top.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("What the fuck are you doing?!")
    }
}
