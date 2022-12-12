import UIKit
import API
import Model

public enum TimelineScreenBuilder {
    @MainActor
    public static func build() -> UIViewController {
        actor APIClientMock: APIClientProtocol {
            func fetchTweets() async -> [Tweet] {
                try! await Task.sleep(nanoseconds: 2_000_000_000)
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
        return hostingVc
    }
}
