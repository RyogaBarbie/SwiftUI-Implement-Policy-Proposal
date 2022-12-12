import Foundation

extension NotificationCenter: @unchecked Sendable {}

extension Notification.Name {
    static let editProfileRouteType = Notification.Name(rawValue: "EditProfileRouteType")
}
