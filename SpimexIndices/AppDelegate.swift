//
//  AppDelegate.swift
//  SpimexIndices
//
//  Created by Anna Vondrukhova on 13.03.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IndexesStorageManager.shared.updateIndexes()
        
        let tabBarController = TabBarViewController()
        UITabBar.appearance().tintColor = .black
        self.window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }


}

