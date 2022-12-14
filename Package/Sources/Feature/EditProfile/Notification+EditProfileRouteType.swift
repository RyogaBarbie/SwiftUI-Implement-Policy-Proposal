import Foundation

extension NotificationCenter: @unchecked Sendable {}

extension Notification.Name {
    static let editProfileOutput = Notification.Name(rawValue: "EditProfileOutput")
}
