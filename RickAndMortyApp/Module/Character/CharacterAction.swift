import Foundation

enum CharacterAction {
    
    enum FilterType {
        case name(String)
        case species(String)
        case gender(CharacterFilterState.Gender)
        case status(CharacterFilterState.Status)
    }
    
    case setFilter(FilterType)
    case pageUp
    case getCharacters
    case setCharacters(_ data: [Character], pages: Int)
    case showError(String)
}
