import Model

struct EditProfileViewData: Sendable, Equatable {
    var id: String
    var name: String
    var introduction: String
    var birthDay: String?
    var imageName: String
    var validatedIdErrorMessage: String? = nil
    var validatedNameErrorMessage: String? = nil
    var isEnableSaveButton: Bool = true
}


extension EditProfileViewData {
    static func convert(_ user: User) -> EditProfileViewData {
        EditProfileViewData(
            id: user.id,
            name: user.name,
            introduction: user.introduction,
            birthDay: user.birthDay,
            imageName: user.imageName
        )
    }
}
