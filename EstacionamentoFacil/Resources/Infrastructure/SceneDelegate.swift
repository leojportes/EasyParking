//
//  SceneDelegate.swift
//  EstacionamentoFacil
//
//  Created by Leonardo Portes on 24/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController()
        navigation.setNavigationBarHidden(false, animated: false)
      
        let configuration = CoordinatorConfiguration(navigationController: navigation)
        let coordinator = LoginCoordinator(with: configuration)
//        let coordinator = HomeCoordinator(with: configuration)
        coordinator.start()
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }

}
