//
//  AppDelegate.swift
//  Library
//
//  Created by Paul Jones on 4/18/18.
//  Copyright © 2018 PLJNS. All rights reserved.
//

import UIKit
import LibraryTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        LibraryTheme.applyTheme(in: window)
        return true
    }
}

