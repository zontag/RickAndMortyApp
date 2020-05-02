//
//  CharactersView.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 01/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import UIKit
import SnapKit

final class CharacterView: UIView {
    
    // MARK: - Views
    private var collectionView: UICollectionView!
    
    private var shouldUpdateConstraints = true
        
    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialization() {
        self.backgroundColor = .white
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        self.addSubview(collectionView)
    }
    
    override func updateConstraints() {
        guard shouldUpdateConstraints else {
            super.updateConstraints()
            return
        }
        
        shouldUpdateConstraints = false
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Public API
}
