import SwiftUI

@MainActor
final class EditProfileScreenViewModel: ObservableObject {
    @Published var state: State
    private let environment: Environment

    init(
        state: State,
        environment: Environment
    ) {
        self.state = state
        self.environment = environment
    }

    struct State: Sendable {
        
    }

    struct Environment: Sendable {
        let notificationCenter: NotificationCenter
    }

    enum Action: Sendable {
        case didTapSave
    }

    enum RouteType: Sendable {
        case myProfile
    }

    func send(_ action: Action) {
        switch action {
        case .didTapSave:
            self.environment.notificationCenter.post(
                name: Notification.Name.editProfileRouteType,
                object: RouteType.myProfile
            )
        }
    }

}
