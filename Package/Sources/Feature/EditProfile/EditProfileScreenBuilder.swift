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
            for await notification in notificationCenter.notifications(named: Notification.Name.editProfileOutput, object: nil) {
                
                switch notification.object as? EditProfileScreenViewModel.Output {
                case .routeTomyProfile:
                    debugPrint("ユーザープロフィールに遷移します")
                case let .setIsEnableSaveButton(bool):
                    hostingVc.setIsEnableSaveButton(bool)
                case .none: break
                }

            }
        }

        return hostingVc
    }
}
