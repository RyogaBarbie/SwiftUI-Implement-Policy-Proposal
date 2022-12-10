import Foundation
import UIKit
import Timeline
import Design

class BaseTabBarController: UITabBarController {
//    private let featureProvider: FeatureProviderProtocol
//
//    init(
//        featureProvider: FeatureProviderProtocol
//    ) {
//        self.featureProvider = featureProvider
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init() {
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
        let tweetVc = TimelineScreenBuilder.build()
        tweetVc.setupTabBarItem(title: "ホーム", image: UIImage(systemName: "house.fill"))

        let tweetVc2 = TimelineScreenBuilder.build()
        tweetVc2.setupTabBarItem(title: "プロフィール変更", image: UIImage(systemName: "person.crop.circle"))

        
        setViewControllers([tweetVc, tweetVc2], animated: false)
    }
}
