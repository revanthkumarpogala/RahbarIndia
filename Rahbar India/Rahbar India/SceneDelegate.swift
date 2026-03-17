//
//  SceneDelegate.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Show Splash Screen First
        let splashVC = storyboard.instantiateViewController(withIdentifier: "splashVC")
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()

        let userId = UserSessionManager.shared.getUser()?.id ?? 0

        // Helper function for smooth transition
        func switchRoot(to viewController: UIViewController) {
            guard let window = self.window else { return }
            
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                window.rootViewController = viewController
            }, completion: nil)
        }

        if userId != 0 {
            // User already logged in
            
            AuthService.shared.fetchWebViewToken { result in
                
                DispatchQueue.main.async {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        switch result {
                            
                        case .success(let token):
                            print("Token:", token)
                            UserSessionManager.shared.saveWebToken(token: token)
                            
                            let navController = storyboard.instantiateViewController(withIdentifier: "webnav") as! UINavigationController
                            switchRoot(to: navController)
                            
                        case .failure(let error):
                            print("Error:", error.localizedDescription)
                            
                            // Fallback to login if API fails
                            let navController = storyboard.instantiateViewController(withIdentifier: "lognav") as! UINavigationController
                            switchRoot(to: navController)
                        }
                    }
                }
            }

        } else {
            // User not logged in
            
            let navController = storyboard.instantiateViewController(withIdentifier: "lognav") as! UINavigationController
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                switchRoot(to: navController)
            }
        }
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

