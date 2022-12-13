import Foundation
import Actomaton
import ActomatonUI
import API
import Model

enum TimelineScreenViewModel {
    struct State: Sendable, Equatable {
        var isLoadingFetchTweets: Bool = true
        var isPresentedTweetView: Bool = false
        var tweetItemModels: [TweetItemViewData]
    }

    enum Action: Sendable {
        case setIsPresentedTweetView(Bool)
        case onAppear
        case refresh
        case _fetchTweets
        case _convertTweetItemViewDataAndSet([Tweet])
        case didTapRetweet(TweetItemViewData)
        case didTapLike(TweetItemViewData)
        case didTapShare(TweetItemViewData)
        case loadImage(TweetItemViewData)
        case setImage(TweetItemViewData)
    }

    enum RouteType: Sendable {
        case showShareActivity(String, URL)
    }

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
                    return ._convertTweetItemViewDataAndSet(tweets)
                }

            case let ._convertTweetItemViewDataAndSet(tweets):
                state.tweetItemModels = TweetItemViewData.bulkConvert(tweets)
                state.isLoadingFetchTweets = false
                return .empty

            case let .didTapRetweet(tweetItemModel):
                // 本来はAPIを叩く
                guard let index = state.tweetItemModels.firstIndex(where: { model in
                    model == tweetItemModel
                }) else { return .empty }

                state.tweetItemModels[index].tweet.isRetweet.toggle()
                return .empty

            case let .didTapLike(tweetItemModel):
                // 本来はAPIを叩く
                guard let index = state.tweetItemModels.firstIndex(where: { model in
                    model == tweetItemModel
                }) else { return .empty }

                state.tweetItemModels[index].tweet.isLike.toggle()
                return .empty

            case let .didTapShare(tweetItemModel):
                return Effect.fireAndForget {
                    routeEnvironment.sendRoute(
                        .showShareActivity(
                            "\(tweetItemModel.tweet.user.name)さんのツイート",
                            URL(string: "https://twitter.com/\(tweetItemModel.tweet.user.id)")!
                        )
                    )
                }

            case let .loadImage(tweetItemModel):
                // 本来は個別のtweetに紐づく何かをapiから取得しsetするイメージ
                // サンプル用に画像でやってます
                guard let index = state.tweetItemModels.firstIndex(where: { model in
                    model == tweetItemModel
                }) else { return .empty }

                state.tweetItemModels[index].isLoadingUserImage = true

                return Effect {
                    // 本来はAPIを叩くような想定
                    let randomSec = Int.random(in: 0...5)
                    _ = try! await Task.sleep(nanoseconds: UInt64(1_000_000_000 * randomSec))
                    return .setImage(tweetItemModel)
                }

            case let .setImage(tweetItemModel):
                guard let index = state.tweetItemModels.firstIndex(where: { model in
                    model == tweetItemModel
                }) else { return .empty }

                state.tweetItemModels[index].isLoadingUserImage = false
                return .empty

            }
        }
    }
}
