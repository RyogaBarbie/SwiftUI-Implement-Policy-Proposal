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
