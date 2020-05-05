import Foundation

struct Response<Result: Codable>: Codable {
    let info : Info
    let results : [Result]
}
