import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    
    var tabBarController: UITabBarController
    
    var characterCoordinator: CharacterCoordinator
    var locationCoordinator: LocationCoordinator
    var episodeCoordinator: EpisodeCoordinator
    
    private var characterStore = Store<CharacterState, CharacterAction>(
    initialState: CharacterState(
        filter: .init(
            name: "",
            species: "",
            status: .none,
            gender: .none),
        isLoading: false,
        items: [],
        page: 0,
        pages: 0,
        errorMessage: nil),
    reducer: characterReducer)
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.tabBarController.view.backgroundColor = .white
        self.tabBarController.tabBar.tintColor = .primary
        
        let characterPresenter = UINavigationController()
        characterPresenter.navigationBar.prefersLargeTitles = true
        characterPresenter.tabBarItem = UITabBarItem(title: "Character",
                                                     image: #imageLiteral(resourceName: "tab_character_inactive"),
                                                     selectedImage: #imageLiteral(resourceName: "tab_character_active"))
        self.characterCoordinator = CharacterCoordinator(
            presenter: characterPresenter,
            store: characterStore)
        
        let locationPresenter = UINavigationController()
        locationPresenter.navigationBar.prefersLargeTitles = true
        locationPresenter.tabBarItem = UITabBarItem(title: "Location",
                                                    image: #imageLiteral(resourceName: "tab_location_inactive"),
                                                    selectedImage: #imageLiteral(resourceName: "tab_location_active"))
        self.locationCoordinator = LocationCoordinator(presenter: locationPresenter)
        
        let episodePresenter = UINavigationController()
        episodePresenter.navigationBar.prefersLargeTitles = true
        episodePresenter.tabBarItem = UITabBarItem(title: "Episode",
                                                   image: #imageLiteral(resourceName: "tab_episode_inactive"),
                                                   selectedImage: #imageLiteral(resourceName: "tab_episode_active"))
        self.episodeCoordinator = EpisodeCoordinator(presenter: episodePresenter)
        
        tabBarController.setViewControllers(
            [characterPresenter,
             locationPresenter,
             episodePresenter],
            animated: false)
    }
    
    func start() {
        characterCoordinator.start()
        locationCoordinator.start()
        episodeCoordinator.start()
    }
}
