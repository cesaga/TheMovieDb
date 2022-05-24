//
//  SceneDelegate.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = setupTabBar()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setupTabBar() -> UIViewController {
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .darkGray
        tabBarController.tabBar.barTintColor = .systemGray6
        
        let movieListViewModel = MovieListViewModel(repository: MovieRepository(), storage: FavoritesManager.shared)
        let movieListViewController = MovieListViewController(movieListViewModel: movieListViewModel)
        movieListViewModel.view = movieListViewController
        
        let favoritesViewModel = FavoritesViewModel(favoritesRepository: FavoritesRepository(storage: FavoritesManager.shared), storage: FavoritesManager.shared)
        let favoritesViewController = FavoritesViewController(favoritesViewModel: favoritesViewModel)
        favoritesViewModel.view = favoritesViewController
        
        let moviesNavigationController = setupNavigationController(viewController: movieListViewController,
                                                                      title: "Movies", image: UIImage(systemName: "house")!,
                                                                      selectedImage: UIImage(systemName: "house.fill")!)
      
        let favoritesNavigationController = setupNavigationController(viewController: favoritesViewController,
                                                                   title: "Favorites", image: UIImage(systemName: "star")!,
                                                                      selectedImage: (UIImage(systemName: "star.fill")!.withRenderingMode(.alwaysOriginal)))
        
        tabBarController.viewControllers = [moviesNavigationController, favoritesNavigationController]
        return tabBarController
    }
    
    func setupNavigationController(viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
      
        return navigationController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
