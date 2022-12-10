import Foundation

/// APIのResponseを元に生成される
struct Tweet: Equatable {
    let id: UUID = UUID()
    let postedAt: Date
    let text: String
    
    let replyCount: Int
    let retweetCount: Int
    let likeCount: Int
}
