import UIKit
import API
import Model

public enum TimelineScreenBuilder {
    @MainActor
    public static func build() -> UIViewController {
        actor APIClientMock: APIClientProtocol {
            func fetchTweets() async -> [Tweet] {
                try! await Task.sleep(nanoseconds: 1_500_000_000)
                return Tweet.sample()
            }

            func fetchUser() async -> User {
                return User.eiko()
            }
        }
        let store = TimelineScreenViewModel.RouteStore(
            state: .init(tweetItemModels: []),
            reducer: TimelineScreenViewModel.reducer(),
            environment: .init(
                apiClient: APIClientMock()
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
