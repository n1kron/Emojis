//
//  AppDelegate.swift
//  Emojis
//
//  Created by  Kostantin Zarubin on 31.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import AppsFlyerLib
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import FacebookShare

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerTrackerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppsFlyerTracker.shared().appsFlyerDevKey = "ij9E8xjzQ8CnqQu9WWvYfM"
        AppsFlyerTracker.shared().appleAppID = "1435728419"
        AppsFlyerTracker.shared().delegate = self
        
        if !UserDefaults.standard.bool(forKey: "didSee") {
            UserDefaults.standard.set(true, forKey: "didSee")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Track Installs, updates & sessions(app opens) (You must include this API to enable tracking)
        AppEventsLogger.activate(application)
        AppsFlyerTracker.shared().trackAppLaunch()
    }

}

