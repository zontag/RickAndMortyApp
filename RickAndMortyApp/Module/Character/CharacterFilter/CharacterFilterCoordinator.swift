import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class CharacterFilterCoordinator: Coordinator {
    private let (lifeTime, token) = Lifetime.make()
    private var presenter: UINavigationController
    private var filterVC: CharacterFilterTableViewController
    private var navController: UINavigationController
    private let store: Store<CharacterState, CharacterAction>
    
    init(presenter: UINavigationController, store: Store<CharacterState, CharacterAction>) {
        self.presenter = presenter
        self.store = store
        self.filterVC = CharacterFilterTableViewController(store: self.store)
        self.navController = UINavigationController(rootViewController: filterVC)
        self.navController.navigationBar.isTranslucent = false
        self.navController.navigationBar.barTintColor = .white
        self.navController.navigationBar.shadowImage = UIImage()
        filterVC.title = "Filter"
        filterVC.delegate = self
    }
    
    func start() {
        self.presenter.present(navController, animated: true, completion: nil)
    }
}

extension CharacterFilterCoordinator: CharacterFilterTableViewControllerDelegate {
    func goSearchForName() {
        let searchVC = SearchTableViewController(
            valuesProvider: store.state.signal
                .map(\.items)
                .map { characters in
                    return characters
                        .map { character in
                            return character.name }})
        
        searchVC.inputValue
            .signal
            .take(during: lifeTime)
            .filter { $0.count > 3 }
            .delay(0.3, on: QueueScheduler.main)
            .map { return CharacterAction.setFilter(.name($0)) }
            .observeValues(self.store.send)

        self.navController.show(searchVC, sender: self)
    }
    
    func goSearchForSpecies() {
        let searchVC = SearchTableViewController(
            valuesProvider: store.state.signal
                .map(\.items)
                .map { characters in
                    return characters
                        .map { character in
                            return character.species }}
                .map { species in
                    Array(Set(species)) }) // Trick to remove duplicates
        
        searchVC.inputValue
            .signal
            .take(during: lifeTime)
            .filter { $0.count > 2 }
            .delay(0.3, on: QueueScheduler.main)
            .map { return CharacterAction.setFilter(.species($0)) }
            .observeValues(self.store.send)
        
        self.navController.show(searchVC, sender: self)
    }
}
