import Model

/// ViewComponentModel
struct TweetItemModel: Sendable, Equatable {
    var tweet: Tweet

    static func == (lhs: TweetItemModel, rhs: TweetItemModel) -> Bool {
        lhs.tweet == rhs.tweet
    }
}

extension TweetItemModel {
    static func bulkConvert( _ tweets: [Tweet]) -> [TweetItemModel] {
        tweets.map { .convert($0) }
    }
    static func convert(_ tweet: Tweet) -> TweetItemModel {
        TweetItemModel(tweet: tweet)
    }
}
