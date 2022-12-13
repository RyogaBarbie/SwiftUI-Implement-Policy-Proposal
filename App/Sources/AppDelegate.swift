//
//  AppDelegate.swift
//  App
//
//  Created by yamamura ryoga on 2022/08/24.
//

import Foundation
import UIKit
import SwiftUI
import API
import Model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        actor APIClientMock: APIClientProtocol {
            func fetchTweets() async -> [Tweet] {
                try! await Task.sleep(nanoseconds: 1_500_000_000)
                return Tweet.sample()
            }

            func fetchUser() async -> User {
                try! await Task.sleep(nanoseconds: 500_000_000)
                return User.random()
            }
        }

        let featureProvider = FeatureProvider(apiClient: APIClientMock())
        let tabbarController = BaseTabBarController(
            featureProvider: featureProvider
        )

        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }
}
