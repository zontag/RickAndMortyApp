import Foundation
import Moya

var appEnvironment: Environment = AppEnvironment()

protocol Environment {
    func callAsFunction() -> MoyaProvider<RMService>
    func callAsFunction() -> RMProvider
}

struct AppEnvironment: Environment {
    
    private var rmService = MoyaProvider<RMService>()
    
    func callAsFunction() -> MoyaProvider<RMService> {
        return self.rmService
    }
    
    func callAsFunction() -> RMProvider {
        return RMProvider.shared
    }
}
