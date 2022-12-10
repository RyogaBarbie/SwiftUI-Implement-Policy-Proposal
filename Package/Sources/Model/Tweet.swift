import Foundation

/// APIのResponseを元に生成される
public struct Tweet: Sendable, Equatable {
    public let id: UUID = UUID()
    public let postedAt: Date
    public let text: String
    
    public let replyCount: Int
    public let retweetCount: Int
    public let likeCount: Int
}
