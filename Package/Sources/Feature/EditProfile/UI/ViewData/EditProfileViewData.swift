import Foundation
import Model

struct EditProfileViewData: Sendable, Equatable {
    var userFormSectionViewData: UserFormSectionViewData
    var birthDay: String?
    var imageName: String
    
    let birthDayOptions: [String] = {
        let format = Date.FormatStyle().locale(Locale(identifier: "ja_JP"))
        var values: [String] = [""]
        let day = try! Date("2023-01-01 00:00:00", strategy: format)
        for i in 0...364 {
            let oneDay = 60 * 60 * 24
            values.append(day.addingTimeInterval(TimeInterval(oneDay * i)).formatted(.dateTime.locale(Locale(identifier: "ja_JP")).month().day()))
        }
        return values
    }()

    var isPresentBirthDayPickerView: Bool = false
    // Navigation周りもSwiftUIで実装する場合
    // var isEnableSaveButton: Bool = true

    var isPresentAlert: Bool = false
    var alertMessage: String? = nil
}


extension EditProfileViewData {
    static func convert(_ user: User) -> EditProfileViewData {
        EditProfileViewData(
            userFormSectionViewData: .init(
                id: user.id,
                name: user.name,
                introduction: user.introduction
            ),
            birthDay: user.birthDay,
            imageName: user.imageName
        )
    }
}
