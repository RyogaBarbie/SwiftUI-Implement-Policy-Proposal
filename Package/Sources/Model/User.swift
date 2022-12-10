import Foundation

public enum FollowState: Sendable {
    case follow, unfollow
}

/// APIのResponseを元に生成される
public struct User: Sendable, Equatable {
    public let id: String
    public var name: String
    public var introduction: String
    public var birthDay: Date
    public let imageName: String
    public var isFollow: FollowState?
}
