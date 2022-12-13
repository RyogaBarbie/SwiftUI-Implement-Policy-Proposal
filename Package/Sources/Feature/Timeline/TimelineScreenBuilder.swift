import UIKit
import API
import Model

public enum TimelineScreenBuilder {
    @MainActor
    public static func build(
        apiClient: APIClientProtocol
    ) -> UIViewController {
        let store = TimelineScreenViewModel.RouteStore(
            state: .init(tweetItemModels: []),
            reducer: TimelineScreenViewModel.reducer(),
            environment: .init(
                apiClient: apiClient
            )
        )

        let hostingVc = TimelineScreenViewHostingViewController(
            store: store.noSendRoute
        ) { store in
                TimelineScreenView(store: store)
        }


        store.subscribeRoutes { routeType in
            switch routeType {
            case let .showShareActivity(text, url):
                let activityVC = UIActivityViewController(activityItems: [text, url], applicationActivities: nil)
                hostingVc.present(activityVC, animated: true, completion: nil)
            }
        }


        return hostingVc
    }
}
