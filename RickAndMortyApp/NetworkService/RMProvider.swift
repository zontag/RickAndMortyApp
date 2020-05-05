//
//  RMProvider.swift
//  RickAndMortyApp
//
//  Created by Tiago Louis Zontag on 03/05/20.
//  Copyright © 2020 Tiago Louis Zontag. All rights reserved.
//

import Foundation
import Moya
import ReactiveSwift
import ReactiveMoya

class RMProvider: Injectable {
    
    enum Failure: LocalizedError {
        case fetchFailure
        
        var localizedDescription: String {
            switch self {
            case .fetchFailure:
                return "Sorry, something really strange happened. 🤯"
            }
        }
    }
    
    static let shared = RMProvider()
    
    private lazy var rmService: MoyaProvider<RMService> = self.resolver()
    
    private init () { }
    
    func fetchCharacters(page: Int) -> SignalProducer<([Character], Int), Failure> {
        rmService.reactive.request(.characters(page: page))
            .logEvents()
            .map(Response<Character>.self)
            .map { ($0.results, $0.info.pages) }
            .mapError { _ in return Failure.fetchFailure }
    }
}
