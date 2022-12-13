import UIKit
import FeatureProvider
import Timeline
import EditProfile
import API

@MainActor
class FeatureProvider: FeatureProviderProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func build(
        _ request: TimelineViewRequest
    ) -> UIViewController {
        TimelineScreenBuilder.build(
            apiClient: apiClient
        )
    }

    func build(
        _ request: EdiitProfileViewRequest
    ) -> UIViewController {
        return EditProfileScreenBuilder.build(
            notificationCenter: NotificationCenter.default,
            apiClient: apiClient
        )
    }
}

