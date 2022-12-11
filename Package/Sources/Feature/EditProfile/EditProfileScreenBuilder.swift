import Foundation
import UIKit

public enum EditProfileScreenBuilder {
    @MainActor public static func build() -> UIViewController {
        let store = EditProfileScreenViewModel.RouteStore(
            state: .init(),
            reducer: EditProfileScreenViewModel.reducer(),
            environment: .init()
        )
        let hostingVc = EditProfileScreenViewHostingViewController(
            store: store.noSendRoute
        ) { store in
                EditProfileScreenView(store: store)
        }
        return hostingVc
    }
}
