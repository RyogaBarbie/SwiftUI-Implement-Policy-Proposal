import Actomaton
import ActomatonUI
import API
import Model

enum TimelineScreenViewModel {
    struct State: Sendable, Equatable {
        var isLoadingFetchTweets: Bool = true
        var isPresentedTweetView: Bool = false
        var tweetItemModels: [TweetItemModel]
    }

    enum Action: Sendable {
        case setIsPresentedTweetView(Bool)
        case onAppear
        case refresh
        case _fetchTweets
        case _convertTweetItemModelAndSet([Tweet])
    }

    enum RouteType: Sendable {}

    struct _Environment: Sendable {
        let apiClient: APIClientProtocol
    }

    typealias Environment = ActomatonUI.SendRouteEnvironment<_Environment, RouteType>

    typealias RouteStore = ActomatonUI.RouteStore<Action, State, _Environment, RouteType>
    typealias Store = ActomatonUI.Store<TimelineScreenViewModel.Action, TimelineScreenViewModel.State, TimelineScreenViewModel._Environment>

    static func reducer() -> Reducer<Action, State, Environment> {
        .init { action, state, routeEnvironment in
            switch action {
            case let .setIsPresentedTweetView(bool):
                state.isPresentedTweetView = bool
                return .empty

            case .onAppear, .refresh:
                state.isLoadingFetchTweets = true
                return Effect.nextAction(._fetchTweets)

            case ._fetchTweets:
                return Effect {
                    let tweets = await routeEnvironment.environment.apiClient.fetchTweets()
                    return ._convertTweetItemModelAndSet(tweets)
                }

            case let ._convertTweetItemModelAndSet(tweets):
                state.tweetItemModels = TweetItemModel.bulkConvert(tweets)
                state.isLoadingFetchTweets = false
                return .empty

            }
        }
    }
}
