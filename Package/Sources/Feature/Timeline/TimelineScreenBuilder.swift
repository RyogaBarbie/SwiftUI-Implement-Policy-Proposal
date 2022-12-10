import UIKit

public enum TimelineScreenBuilder {
    @MainActor
    public static func build() -> UIViewController {
        let store = TimelineScreenViewModel.RouteStore(
            state: .init(tweetItemModels: []),
            reducer: TimelineScreenViewModel.reducer(),
            environment: .init()
        )
        let hostingVc = TimelineScreenViewHostingViewController(
            store: store.noSendRoute
        ) { store in
                TimelineScreenView(store: store)
        }
        return hostingVc
    }
}
