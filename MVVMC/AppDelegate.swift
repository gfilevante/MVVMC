//
//  AppDelegate.swift
//  MoyaTest
//
//  Created by belga on 10/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator!
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
  {
    
    window = UIWindow()
    appCoordinator = AppCoordinator(window: window!)
    appCoordinator.start()
    window?.makeKeyAndVisible()
    
    return true
  }



}

