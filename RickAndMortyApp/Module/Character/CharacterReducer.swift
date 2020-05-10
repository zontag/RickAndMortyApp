import Foundation
import ReactiveSwift
import ReactiveCocoa

var characterReducer = Reducer<CharacterState, CharacterAction>(environment: appEnvironment) { state, action, environment in
    switch action {
    case .pageUp:
        let old = state.value
        state.value = CharacterState(
            filter: .init(
                name: old.filter.name,
                species: old.filter.species,
                status: old.filter.status,
                gender: old.filter.gender),
            isLoading: false,
            items: old.items,
            page: old.page + 1,
            pages: old.pages,
            errorMessage: nil)
        return SignalProducer(value: CharacterAction.getCharacters)
    case .getCharacters:
        let old = state.value
        state.value = CharacterState(
            filter: .init(
                name: old.filter.name,
                species: old.filter.species,
                status: old.filter.status,
                gender: old.filter.gender),
            isLoading: true,
            items: old.items,
            page: old.page,
            pages: old.pages,
            errorMessage: nil)
        let rmProvider: RMProvider = environment.resolve()
        return rmProvider
            .fetchCharacters(
                page: state.value.page,
                name: state.value.filter.name,
                status: state.value.filter.status.rawValue,
                gender: state.value.filter.gender.rawValue,
                species: state.value.filter.species)
            .retry(upTo: 3)
            .map { (characters, pages) in
                CharacterAction.setCharacters(characters, pages: pages)
        }.flatMapError { error in
            SignalProducer(value: CharacterAction.showError(error.localizedDescription))
        }
    case let .setCharacters(characters, pages):
        let old = state.value
        state.value = CharacterState(
            filter: .init(
                name: old.filter.name,
                species: old.filter.species,
                status: old.filter.status,
                gender: old.filter.gender),
            isLoading: false,
            items: old.items + characters,
            page: old.page,
            pages: pages,
            errorMessage: nil)
    case .showError(let message):
        let old = state.value
        state.value = CharacterState(
            filter: .init(
                name: old.filter.name,
                species: old.filter.species,
                status: old.filter.status,
                gender: old.filter.gender),
            isLoading: false,
            items: old.items,
            page: old.page,
            pages: old.pages,
            errorMessage: message)
    case let .setFilter(type):
        let old = state.value
        var newFilter: CharacterFilterState
        switch type {
        case let .name(value):
            newFilter = .init(
                name: value,
                species: old.filter.species,
                status: old.filter.status,
                gender: old.filter.gender)
        case let .species(value):
            newFilter = .init(
                name: old.filter.name,
                species: value,
                status: old.filter.status,
                gender: old.filter.gender)
        case let .gender(value):
            newFilter = .init(
                name: old.filter.name,
                species: old.filter.species,
                status: old.filter.status,
                gender: value)
        case let .status(value):
            newFilter = .init(
                name: old.filter.name,
                species: old.filter.species,
                status: value,
                gender: old.filter.gender)
        }
        state.value = CharacterState(
            filter: newFilter,
            isLoading: old.isLoading,
            items: [],
            page: 1,
            pages: 0,
            errorMessage: nil)
        return SignalProducer(value: CharacterAction.getCharacters)
    }
    return nil
}
