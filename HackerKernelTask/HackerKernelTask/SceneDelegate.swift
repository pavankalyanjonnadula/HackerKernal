//
//  SceneDelegate.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit
import Foundation
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainNavigationController = UINavigationController()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowscene = scene as? UIWindowScene{
            let window = UIWindow(windowScene: windowscene)
            self.window = window
            checkForPreviousLogin()
        
        }
    }
    func checkForPreviousLogin(){
        let loginDetails = getObject(forKey: "login") as? NSDictionary ?? [:]
        print(loginDetails)
        if loginDetails.count > 0{
            let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            self.mainNavigationController = UINavigationController(rootViewController: initialVC)
            self.mainNavigationController.navigationBar.isHidden = true
            self.window?.rootViewController = self.mainNavigationController
        }
        else{
            let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.mainNavigationController = UINavigationController(rootViewController: initialVC)
            self.mainNavigationController.navigationBar.isHidden = true
            self.window?.rootViewController = self.mainNavigationController
        }
        window?.makeKeyAndVisible()
    }
    
    func getObject(forKey:String)->AnyObject? {
          let defaults = UserDefaults.standard
          var decodedArray : AnyObject!
          //Checking if the data exists
          if defaults.data(forKey: forKey) != nil {
              //Getting Encoded Array
              let encodedArray = defaults.data(forKey: forKey)
              //Decoding the Array
              decodedArray = NSKeyedUnarchiver.unarchiveObject(with: encodedArray!) as AnyObject
          }
          return decodedArray
      }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

