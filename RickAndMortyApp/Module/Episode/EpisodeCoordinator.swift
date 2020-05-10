import Foundation
import UIKit

class EpisodeCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var episodeVC: UIViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let episodeVC = UIViewController()
        episodeVC.title = "Episode"
        let button = UIBarButtonItem.createPlain(title: "Filter", target: self, action: #selector(filterAction))
        episodeVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(episodeVC, animated: true)
        self.episodeVC = episodeVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
