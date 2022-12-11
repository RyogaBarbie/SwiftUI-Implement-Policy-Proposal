import UIKit
import FeatureProvider
import Timeline
import EditProfile

@MainActor
class FeatureProvider: FeatureProviderProtocol {
    
    func build(
        _ request: TimelineViewRequest
    ) -> UIViewController {
        TimelineScreenBuilder.build()
    }

    func build(
        _ request: EdiitProfileViewRequest
    ) -> UIViewController {
        EditProfileScreenBuilder.build()
    }
}

