import Actomaton
import ActomatonUI

enum TimelineScreenViewModel {
    struct State: Sendable, Equatable {
        var isPresentedTweetView: Bool = false
        let tweetItemModels: [TweetItemModel]
    }

    enum Action: Sendable {
        case setIsPresentedTweetView(Bool)
    }

    enum RouteType: Sendable {}

    struct _Environment: Sendable {}

    typealias Environment = ActomatonUI.SendRouteEnvironment<_Environment, RouteType>

    typealias RouteStore = ActomatonUI.RouteStore<Action, State, _Environment, RouteType>
    typealias Store = ActomatonUI.Store<TimelineScreenViewModel.Action, TimelineScreenViewModel.State, TimelineScreenViewModel._Environment>

    static func reducer() -> Reducer<Action, State, Environment> {
        .init { action, state, environment in
            switch action {
            case let .setIsPresentedTweetView(bool):
                state.isPresentedTweetView = bool
                return .empty
            }
        }
    }
}
