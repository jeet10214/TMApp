//
//  AppDelegate.swift
//  TMApp
//
//  Created by Jeet Kapadia on 12/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRoot()
        return true
    }
    
    private func setRoot() {
        window = UIWindow()
        let trendingView = TrendingMoviesModuleBuilder().buildModule()
        let navigationController = UINavigationController(rootViewController: trendingView)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

