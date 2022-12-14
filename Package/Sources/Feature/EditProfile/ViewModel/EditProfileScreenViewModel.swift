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
        case _validateUser
        case didTapSave
        case setIsPresentAlert(Bool)
    }

    enum Output: Sendable {
        case routeTomyProfile
        case setIsEnableSaveButton(Bool)
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
            state.editProfileViewData?.userFormSectionViewData.id = value
            send(._validateUser)

        case let .updateName(value):
            state.editProfileViewData?.userFormSectionViewData.name = value
            send(._validateUser)

        case let .updateIntroduction(value):
            state.editProfileViewData?.userFormSectionViewData.introduction = value

        case let .setIsPresentBirthDayPickerView(value):
            state.editProfileViewData?.isPresentBirthDayPickerView = value
            
        case let .updateBirthDay(value):
            state.editProfileViewData?.birthDay = value
            
        case ._validateUser:
            guard let editProfileViewData = state.editProfileViewData else { return }

            let errorMessageForId: String? = validateId(editProfileViewData.userFormSectionViewData.id) ? nil : "5???????????????????????????????????????"
            state.editProfileViewData?.userFormSectionViewData.validatedIdErrorMessage = errorMessageForId

            let errorMessageForName: String? = validateName(editProfileViewData.userFormSectionViewData.name) ? nil : "2???????????????????????????????????????"
            state.editProfileViewData?.userFormSectionViewData.validatedNameErrorMessage = errorMessageForName
            
            let isEnableSaveButton = (errorMessageForId == nil && errorMessageForName == nil)
            
            // Navigation?????????SwiftUI?????????????????????
            // state.editProfileViewData?.isEnableSaveButton = isEnableSaveButton
            
            environment.notificationCenter.post(
                name: Notification.Name.editProfileOutput,
                object: Output.setIsEnableSaveButton(isEnableSaveButton)
            )

        case .didTapSave:
            guard let editProfileViewData = state.editProfileViewData else { return }

            Task.detached {
                let result = await self.environment.apiClient.updateUser(
                    id: editProfileViewData.userFormSectionViewData.id,
                    name: editProfileViewData.userFormSectionViewData.name,
                    introduction: editProfileViewData.userFormSectionViewData.introduction,
                    birtyDay: editProfileViewData.birthDay
                )
                Task { @MainActor in
                    if result != nil {
                        self.state.editProfileViewData?.alertMessage = "??????????????????"
                    } else {
                        self.state.editProfileViewData?.alertMessage = "???????????????????????????"
                    }
                    self.state.editProfileViewData?.isPresentAlert = true
                }
            }

            // TODO: API???????????????????????????post??????
            environment.notificationCenter.post(
                name: Notification.Name.editProfileOutput,
                object: Output.routeTomyProfile
            )

        case let .setIsPresentAlert(bool):
            state.editProfileViewData?.isPresentAlert = bool
        }
    }

    private func validateId(_ value: String) -> Bool {
        value.count >= 5
    }

    private func validateName(_ value: String) -> Bool {
        value.count >= 2
    }
}
