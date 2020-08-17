//
//  AppDelegate.swift
//  RX+MVVM
//
//  Created by Karem on 8/16/20.
//  Copyright © 2020 Karem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = homeStoryboard.instantiateViewController(identifier: "home")
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        
        return true
    }




}

