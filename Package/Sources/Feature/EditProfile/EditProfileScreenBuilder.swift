import Foundation
import UIKit

public enum EditProfileScreenBuilder {
    @MainActor public static func build() -> UIViewController {
        let vm = EditProfileScreenViewModel(state: .init(), environment: .init())
//        let store = EditProfileScreenViewModel.RouteStore(
//            state: .init(),
//            reducer: EditProfileScreenViewModel.reducer(),
//            environment: .init()
//        )
        let view = EditProfileScreenView(vm: vm)
        let hostingVc = EditProfileScreenViewHostingViewController(view, viewModel: vm)
//        let hostingVc = EditProfileScreenViewHostingViewController(
//            store: store.noSendRoute
//        ) { store in
//                EditProfileScreenView(store: store)
//        }
        return hostingVc
    }
}
