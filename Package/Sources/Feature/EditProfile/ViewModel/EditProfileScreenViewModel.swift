import SwiftUI
import API

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
        var editProfileViewData: EditProfileViewData? = nil
    }

    struct Environment: Sendable {
        let notificationCenter: NotificationCenter
        let apiClient: APIClientProtocol
    }

    enum Action: Sendable {
        case onAppear
        case updateId(String)
        case updateName(String)
        case updateIntroduction(String)
        case setIsPresentBirthDayPickerView(Bool)
        case updateBirthDay(String)
        case didTapSave
    }

    enum RouteType: Sendable {
        case myProfile
    }

    func send(_ action: Action) {
        switch action {
        case .onAppear:
            Task.detached {
                let user = await self.environment.apiClient.fetchUser()
                let editUserViewData = EditProfileViewData.convert(user)
                Task { @MainActor in
                    self.state.editProfileViewData = editUserViewData
                }
            }

        case let .updateId(value):
            state.editProfileViewData?.id = value

            let errorMessage: String? = validateId(value) ? nil : "5文字以上で設定してください"
            state.editProfileViewData?.validatedIdErrorMessage = errorMessage

        case let .updateName(value):
            state.editProfileViewData?.name = value

            let errorMessage: String? = validateName(value) ? nil : "2文字以上で設定してください"
            state.editProfileViewData?.validatedNameErrorMessage = errorMessage

        case let .updateIntroduction(value):
            state.editProfileViewData?.introduction = value

        case let .setIsPresentBirthDayPickerView(value):
            state.editProfileViewData?.isPresentBirthDayPickerView = value
            
        case let .updateBirthDay(value):
            state.editProfileViewData?.birthDay = value

        case .didTapSave:
            self.environment.notificationCenter.post(
                name: Notification.Name.editProfileRouteType,
                object: RouteType.myProfile
            )
        }
    }

    private func validateId(_ value: String) -> Bool {
        value.count >= 5
    }

    private func validateName(_ value: String) -> Bool {
        value.count >= 2
    }
}
