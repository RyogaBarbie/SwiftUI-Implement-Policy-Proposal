import Model

struct TweetItemViewData: Sendable, Equatable {
    var tweet: Tweet
    var isLoadingUserImage: Bool = true

    static func == (lhs: TweetItemViewData, rhs: TweetItemViewData) -> Bool {
        (lhs.tweet == rhs.tweet) && (lhs.isLoadingUserImage == rhs.isLoadingUserImage)
    }
}

extension TweetItemViewData {
    static func bulkConvert( _ tweets: [Tweet]) -> [TweetItemViewData] {
        tweets.map { .convert($0) }
    }
    static func convert(_ tweet: Tweet) -> TweetItemViewData {
        TweetItemViewData(tweet: tweet)
    }
}
