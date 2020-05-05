import Foundation
import ReactiveSwift
import ReactiveCocoa

let characterCardCollectionViewReducer = Reducer<CardCollectionViewController.State, CardCollectionViewController.Action> { state, action, environment in
    switch action {
    case .pageUp:
        let old = state.value
        state.value = CardCollectionViewController.State(
            isLoading: false,
            items: old.items,
            page: old.page + 1,
            pages: old.pages,
            errorMessage: nil)
        return SignalProducer(value:
            CardCollectionViewController.Action.getData(page: state.value.page))
    case .getData(let page):
        let old = state.value
        state.value = CardCollectionViewController.State(
            isLoading: true,
            items: old.items,
            page: old.page,
            pages: old.pages,
            errorMessage: nil)
        let rmProvider: RMProvider = environment()
        return rmProvider
            .fetchCharacters(page: page)
            .retry(upTo: 3)
            .map { (characters, pages) in
                let data = characters.map { character in
                    CardCollectionViewCell.Data(
                        imageUrl: character.image,
                        title: character.status,
                        subtitle: character.name)
                }
                return (data, pages)
        }.map { (data, pages) in
            CardCollectionViewController.Action.setData(data, pages: pages)
        }.flatMapError { error in
            SignalProducer(value: CardCollectionViewController.Action.showError(error.localizedDescription))
        }
    case let .setData(data, pages):
        let old = state.value
        state.value = CardCollectionViewController.State(
            isLoading: false,
            items: old.items + data,
            page: old.page,
            pages: pages,
            errorMessage: nil)
    case .showError(let message):
        let old = state.value
        state.value = CardCollectionViewController.State(
            isLoading: false,
            items: old.items,
            page: old.page,
            pages: old.pages,
            errorMessage: message)
    }
    return nil
}
