import Foundation
import UIKit

class LocationCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var locationVC: UIViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let locationVC = UIViewController()
        locationVC.title = "Location"
        let button = DotPlainBarButtonItem(
            title: "Filter",
            target: self,
            action: #selector(filterAction))
        locationVC.navigationItem.rightBarButtonItem = button
        presenter.pushViewController(locationVC, animated: true)
        self.locationVC = locationVC
    }
    
    @objc private func filterAction(_ sender: AnyObject) {
        self.presentFilterVC()
    }
    
    private func presentFilterVC() {
        
    }
}
