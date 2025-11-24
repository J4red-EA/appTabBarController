//
//  SceneDelegate.swift
//  appTabBarController
//
//  Created by Jared Esquivel on 17/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Cargar el TabBarController del Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // El TabBarController debe ser el Initial View Controller en el Storyboard
        // O darle un Storyboard ID, por ejemplo: "MainTabBarController"
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        
        // Crear el Conversor
        let conversorVC = ConversorNumericoViewController()
        conversorVC.tabBarItem = UITabBarItem(title: "Conversor", image: UIImage(systemName: "number.circle.fill"), tag: 1)
        
        // Añadir el conversor a las vistas existentes del TabBar
        var viewControllers = tabBarController.viewControllers ?? []
        viewControllers.append(conversorVC)
        tabBarController.viewControllers = viewControllers
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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

