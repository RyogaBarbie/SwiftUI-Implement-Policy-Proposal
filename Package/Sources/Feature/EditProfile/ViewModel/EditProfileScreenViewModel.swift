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

    struct Environment: Sendable {}

    enum Action: Sendable {
    }

    enum RouteType: Sendable {
        case repositoryDetail
    }

    func send(_ action: Action) {}

}


//import Actomaton
//import ActomatonUI
//
//enum EditProfileScreenViewModel {
//    struct State: Sendable, Equatable {}
//
//    enum Action: Sendable {}
//
//    enum RouteType: Sendable {}
//
//    struct _Environment: Sendable {}
//
//    typealias Environment = ActomatonUI.SendRouteEnvironment<_Environment, RouteType>
//
//    typealias RouteStore = ActomatonUI.RouteStore<Action, State, _Environment, RouteType>
//    typealias Store = ActomatonUI.Store<EditProfileScreenViewModel.Action, EditProfileScreenViewModel.State, EditProfileScreenViewModel._Environment>
//
//    static func reducer() -> Reducer<Action, State, Environment> {
//
//        .empty
//    }
//}
