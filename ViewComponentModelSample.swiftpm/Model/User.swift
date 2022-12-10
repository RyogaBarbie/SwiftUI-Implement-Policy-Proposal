import Foundation

enum FollowState {
    case follow, unfollow
}

/// APIのResponseを元に生成される
struct User: Equatable {
    let id: String
    var name: String
    var introduction: String
    var birthDay: Date
    let imageName: String
    var isFollow: FollowState?
}
