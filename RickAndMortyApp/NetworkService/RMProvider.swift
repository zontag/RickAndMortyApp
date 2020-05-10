import Foundation
import Moya
import ReactiveSwift
import ReactiveMoya

class RMProvider {
    
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
    
    private lazy var rmService: MoyaProvider<RMService> = appEnvironment.resolve()
    
    private init () { }
    
    func fetchCharacters(
        page: Int,
        name: String,
        status: String,
        gender: String,
        species: String)
        -> SignalProducer<([Character], Int), Failure> {
            rmService.reactive.request(.characters(
                page: page,
                name: name,
                status: status,
                gender: gender,
                species: species))
                .map(Response<Character>.self)
                .map { ($0.results, $0.info.pages) }
                .mapError { _ in return Failure.fetchFailure }
    }
}
