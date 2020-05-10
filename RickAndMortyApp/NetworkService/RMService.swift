import Foundation
import Moya

enum RMService {
    case characters(page: Int, name: String, status: String, gender: String, species: String)
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
        case let .characters(page, name, status, gender, species):
            return .requestParameters(
                parameters: [
                    "page": page,
                    "name": name,
                    "status": status,
                    "gender": gender,
                    "species": species],
                encoding: URLEncoding.queryString)
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
