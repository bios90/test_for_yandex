//
//  AppDelegate.swift
//  test_for_yandex
//
//  Created by Филипп Бесядовский on 23.07.2020.
//  Copyright © 2020 dimfcompany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle



}

