import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UITabBarController
    let tabBarCoordinator: TabBarCoordinator
    
    init(window: UIWindow) { //4
        self.window = window
        rootViewController = UITabBarController()
        self.tabBarCoordinator = TabBarCoordinator(tabBarController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        tabBarCoordinator.start()
        window.makeKeyAndVisible()
    }
}
