import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

//        let envClient = ENVClient()
//        let featureProvider = FeatureProvider(
//            appEnvironment: .init(
//                apiClient: APIClient(
//                    urlSession: URLSession.shared,
//                    envClient: envClient
//                ),
//                envClinet: envClient,
//                userDefaultsClient: UserDefaultsClient(
//                    userDefaults: UserDefaults.standard
//                ),
//                notificationCenter: NotificationCenter.default
//            )
//        )
        
        let tabbarController = BaseTabBarController()
        let tweetVc = TimelineScreenBuilder.build()

        window?.rootViewController = tweetVc
        window?.makeKeyAndVisible()
        return true
    }
}
