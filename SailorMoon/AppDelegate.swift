//
//  AppDelegate.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController(rootViewController: MainPageTableViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

