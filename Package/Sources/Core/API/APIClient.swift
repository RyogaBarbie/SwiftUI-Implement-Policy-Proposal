import Foundation
import Model

/// 擬似的にAPI叩いてる風に見せる用
public protocol APIClientProtocol: Sendable {
    func fetchTweets() async -> [Tweet]
    func fetchUser() async -> User
}
