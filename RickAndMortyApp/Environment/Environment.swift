import Foundation
import Moya

var appEnvironment: Environment = AppEnvironment()

protocol Environment {
    func resolve() -> MoyaProvider<RMService>
    func resolve() -> RMProvider
}

class AppEnvironment: Environment {
    
    private lazy var rmService = MoyaProvider<RMService>(plugins: [NetworkLoggerPlugin()])
    
    func resolve() -> MoyaProvider<RMService> {
        return self.rmService
    }
    
    func resolve() -> RMProvider {
        return RMProvider.shared
    }
}
