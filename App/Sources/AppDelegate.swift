//
//  AppDelegate.swift
//  App
//
//  Created by yamamura ryoga on 2022/08/24.
//

import Foundation
import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        let vc = UIHostingController(rootView: ContentView())
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
