import Foundation
import UIKit
import Timeline
import Design
import FeatureProvider

class BaseTabBarController: UITabBarController {
    private let featureProvider: FeatureProviderProtocol

    init(
        featureProvider: FeatureProviderProtocol
    ) {
        self.featureProvider = featureProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        let tweetVc = featureProvider.build(TimelineViewRequest())
        tweetVc.setupTabBarItem(title: "ホーム", image: UIImage(systemName: "house.fill"))
        let nav = UINavigationController(rootViewController: tweetVc)

        let tweetVc2 = featureProvider.build(EdiitProfileViewRequest())
        tweetVc2.setupTabBarItem(title: "プロフィール変更", image: UIImage(systemName: "person.crop.circle"))
        let nav2 = UINavigationController(rootViewController: tweetVc2)
        
        setViewControllers([nav, nav2], animated: false)
    }
}
