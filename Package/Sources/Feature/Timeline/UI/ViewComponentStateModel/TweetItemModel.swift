import Model

/// ViewComponentModel
struct TweetItemModel: Sendable, Equatable {
    let tweet: Tweet
    var user: User
    var isLike: Bool
    var isReTweet: Bool
    
    static func == (lhs: TweetItemModel, rhs: TweetItemModel) -> Bool {
        lhs.tweet.id == rhs.tweet.id
    }
}

extension TweetItemModel {
    static func sample() -> [TweetItemModel] {
        [
            TweetItemModel(tweet: .ariyoshi(), user: .ariyoshi(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .matsumoto(), user: .matsumoto(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .nobu(), user: .nobu(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .eiko(), user: .eiko(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .tomoya(), user: .tomoya(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .tori(), user: .tori(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .ryoma(), user: .ryoma(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .ariyoshi(), user: .ariyoshi(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .matsumoto(), user: .matsumoto(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .nobu(), user: .nobu(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .eiko(), user: .eiko(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .tomoya(), user: .tomoya(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .tori(), user: .tori(), isLike: false, isReTweet: false),
            TweetItemModel(tweet: .ryoma(), user: .ryoma(), isLike: false, isReTweet: false),
        ].shuffled()
    }
}
