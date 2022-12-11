import UIKit

public enum TimelineScreenBuilder {
    @MainActor
    public static func build() -> UIViewController {
        // 本来、APIからTweetItemModelを生成する
        let sampleData = TweetItemModel.sample()
        let store = TimelineScreenViewModel.RouteStore(
            state: .init(tweetItemModels: sampleData),
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
