//
//  AppDelegate.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/20.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        let env = ProcessInfo.processInfo.environment
        if let id = env["adTest"] {
            GADMobileAds.configure(withApplicationID: id)
        }
        return true
    }
}

