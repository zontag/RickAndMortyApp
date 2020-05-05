import Foundation
import UIKit

class CharacterCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var charactersVC: CardCollectionViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let charactersVC = CardCollectionViewController(reducer: characterCardCollectionViewReducer)
        charactersVC.title = "Character"
        let button = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterAction))
            .plainStyle()
        charactersVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(charactersVC, animated: true)
        self.charactersVC = charactersVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
