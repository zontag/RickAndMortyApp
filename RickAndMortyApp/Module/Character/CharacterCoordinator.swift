import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class CharacterCoordinator: Coordinator {
    private let (lifetime, token) = Lifetime.make()
    private var presenter: UINavigationController
    private var store: Store<CharacterState, CharacterAction>
    private var filterCoordinator: CharacterFilterCoordinator?
    private var charactersVC: CardCollectionViewController?
    
    init(presenter: UINavigationController, store: Store<CharacterState, CharacterAction>) {
        self.presenter = presenter
        self.store = store
    }
    
    func start() {
        let charactersVC = CardCollectionViewController(
            itemsSignal: store.state.map(\.items).map { $0.map { character in
                CardCollectionViewCell.Data(
                    imageUrl: character.image,
                    title: character.status,
                    subtitle: character.name)
                }
            }.signal)
        
        charactersVC.onPrefetchItemsAt
            .signal
            .take(during: lifetime)
            .observeValues { indexPaths in
                guard !self.store.state.value.isLoading,
                    self.store.state.value.page < self.store.state.value.pages,
                    indexPaths.last?.row == self.store.state.value.items.count - 1
                    else {
                        return
                }
                
                
                self.store.send(.pageUp)
        }
        
        charactersVC.didSelectAtRow.signal
            .take(during: lifetime)
            .filter { return $0 != nil }
            .map { $0! }
            .map { self.store.state.value.items[$0] }
            .observe(on: UIScheduler())
            .observeValues { character in
                self.presenter.pushViewController(
                    CharacterDetailTableViewController(
                        character: character),
                    animated: true)
        }
        
        charactersVC.title = "Character"
        let button = DotPlainBarButtonItem(title: "Filter", target: self, action: #selector(filterAction))
        
        charactersVC.navigationItem.rightBarButtonItem = button
        
        self.store.state.signal
            .take(during: lifetime)
            .map(\.filter.isActive)
            .observe(on: UIScheduler())
            .observeValues { isActive in
                button.dotIsHidden = !isActive }
        
        presenter.pushViewController(charactersVC, animated: true)
        self.charactersVC = charactersVC
        self.store.send(.pageUp)
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        self.filterCoordinator = CharacterFilterCoordinator(presenter: self.presenter, store: self.store)
        self.filterCoordinator?.start()
    }
}
