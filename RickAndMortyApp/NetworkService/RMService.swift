import Foundation
import Moya

enum RMService {
    case characters(page: Int)
}

extension RMService: TargetType {
    
    var baseURL: URL { return URL(string: "https://rickandmortyapi.com/api")! }
    
    var path: String {
        switch self {
        case .characters:
            return "/character/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .characters:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .characters(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .characters:
            return "{}".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
