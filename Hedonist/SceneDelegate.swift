//
//  SceneDelegate.swift
//  Hedonist
//
//  Created by a.lobanov on 12/21/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    
    func createTabBarController() -> UITabBarController {
        let tabController = UITabBarController()
        let mainVC = MainBuilder.build()
        let favsVC = FavsBuilder.build()
        let mapVC = MapBuilder.build()
        
        mainVC.tabBarItem = UITabBarItem(title: "Все", image: UIImage(systemName: "antenna.radiowaves.left.and.right.circle.fill"), tag: 0)
        favsVC.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart.circle.fill"), tag: 1)
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map.circle.fill"), tag: 2)
        
        tabController.viewControllers = [mainVC, favsVC, mapVC]
        UITabBar.appearance().backgroundColor = .label
        return tabController
    }
    
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

