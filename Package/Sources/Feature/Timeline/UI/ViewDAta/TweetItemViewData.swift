import Model
import Foundation

struct TweetItemViewData: Sendable, Equatable {
    let tweetId: UUID
    let tweetText: String
    let tweetPostedAt: String
    var isLike: Bool
    var isRetweet: Bool

    let userId: String
    let userName: String
    let userImageName: String

    var isLoadingUserImage: Bool = true

    static func == (lhs: TweetItemViewData, rhs: TweetItemViewData) -> Bool {
        lhs.tweetId == rhs.tweetId &&
            lhs.isLike == rhs.isLike &&
            lhs.isRetweet == rhs.isRetweet &&
            lhs.isLoadingUserImage == rhs.isLoadingUserImage
    }
}

extension TweetItemViewData {
    static func bulkConvert( _ tweets: [Tweet]) -> [TweetItemViewData] {
        tweets.map { .convert($0) }
    }
    static func convert(_ tweet: Tweet) -> TweetItemViewData {
        TweetItemViewData(
            tweetId: tweet.id,
            tweetText: tweet.text,
            tweetPostedAt: tweet.postedAt,
            isLike: tweet.isLike,
            isRetweet: tweet.isRetweet,
            userId: tweet.user.id,
            userName: tweet.user.name,
            userImageName: tweet.user.imageName
        )
    }
}
