import Foundation

struct CharacterFilterState {
    
    enum Status: String {
        case alive
        case dead
        case unknown
        case none = ""
    }
    
    enum Gender: String {
        case female
        case male
        case genderless
        case unknown
        case none = ""
    }
    
    var isActive: Bool {
        !self.name.isEmpty
            || !self.species.isEmpty
            || status != .none
            || gender != .none
    }
    
    let name: String
    let species: String
    let status: Status
    let gender: Gender
}

struct CharacterState {
    let filter: CharacterFilterState
    let isLoading: Bool
    let items: [Character]
    let page: Int
    let pages: Int
    let errorMessage: String?
}
