import Foundation
import UIKit
import API

public enum EditProfileScreenBuilder {
    @MainActor public static func build(
        notificationCenter: NotificationCenter,
        apiClient: APIClientProtocol
    ) -> UIViewController {
        let vm = EditProfileScreenViewModel(state: .init(), environment: .init(notificationCenter: notificationCenter, apiClient: apiClient))
        let view = EditProfileScreenView(vm: vm)
        let hostingVc = EditProfileScreenViewHostingViewController(view, viewModel: vm)

        Task { @MainActor in
            for await notification in notificationCenter.notifications(named: Notification.Name.editProfileRouteType, object: nil) {
                if case .myProfile = notification.object as? EditProfileScreenViewModel.RouteType {
                    // impl 画面遷移
                }
            }
        }

        return hostingVc
    }
}
