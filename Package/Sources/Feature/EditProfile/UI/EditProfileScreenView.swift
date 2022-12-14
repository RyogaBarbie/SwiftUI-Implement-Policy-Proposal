import SwiftUI
import Actomaton
import ActomatonUI

struct EditProfileScreenView: View {
    @ObservedObject private var vm: EditProfileScreenViewModel
    
    init(vm: EditProfileScreenViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        if let editProfileViewData = vm.state.editProfileViewData {
            EditProfileView(
                editProfileViewData: editProfileViewData,
                updateIdClosure: { vm.send(.updateId($0)) },
                updateNameClosure: { vm.send(.updateName($0)) },
                updateIntroductionClosure: { vm.send(.updateIntroduction($0)) },
                updateBirthDayClosure: { vm.send(.updateBirthDay($0)) },
                setIsPresentBirthDayPickerViewClosure: { value in vm.send(.setIsPresentBirthDayPickerView(value)) },
                setIsPresentAlertClosure: { value in vm.send(.setIsPresentAlert(value))}
            )
        } else {
            ProgressView()
                .onAppear {
                    vm.send(.onAppear)
                }
        }
    }

    struct EditProfileView: View {
        let editProfileViewData: EditProfileViewData

        let updateIdClosure: (String) -> Void
        let updateNameClosure: (String) -> Void
        let updateIntroductionClosure: (String) -> Void
        let updateBirthDayClosure: (String) -> Void
        let setIsPresentBirthDayPickerViewClosure: (Bool) -> Void
        let setIsPresentAlertClosure: (Bool) -> Void

        var body: some View {
            VStack {
                Spacer().frame(height: 16)
                
                UserCoverImageView(userImage: editProfileViewData.imageName)
                
                Spacer().frame(height: 24)
                
                UserFormsSectionView(
                    id: editProfileViewData.id,
                    updateIdClosure: updateIdClosure,
                    validateIdErrorMessage: editProfileViewData.validatedIdErrorMessage,
                    name: editProfileViewData.name,
                    updateNameClosure: updateNameClosure,
                    validateNameErrorMessage: editProfileViewData.validatedNameErrorMessage,
                    introduction: editProfileViewData.introduction,
                    updateIntroductionClosure: updateIntroductionClosure,
                    birthDay: editProfileViewData.birthDay,
                    updateBirthDayClosure: updateBirthDayClosure,
                    birthDayOptions: editProfileViewData.birthDayOptions,
                    isPresentBirthDayPickerView: editProfileViewData.isPresentBirthDayPickerView,
                    setIsPresentBirthDayPickerViewClosure: setIsPresentBirthDayPickerViewClosure
                )
                
                Spacer()
            }
            .sheet(isPresented: Binding(get: {
                editProfileViewData.isPresentBirthDayPickerView
            }, set: { newValue in
                setIsPresentBirthDayPickerViewClosure(newValue)
            }), content: {
                BirthDayPickerView(
                    birthDayOptions: editProfileViewData.birthDayOptions,
                    birthDay: editProfileViewData.birthDay,
                    updateClosure: updateBirthDayClosure,
                    setIsPresentClosure: setIsPresentBirthDayPickerViewClosure
                )
                .presentationDetents([.fraction(0.4)])
            })
            .alert("保存", isPresented: Binding(get: { editProfileViewData.isPresentAlert }, set: { newValue in
                setIsPresentAlertClosure(newValue)
            })) {
                Button("閉じる") {
                    setIsPresentAlertClosure(false)
                }
            } message: {
                Text(editProfileViewData.alertMessage ?? "")
            }
        }
    }

    struct UserCoverImageView: View {
        let userImage: String?

        var body: some View {
            if let userImage {
                Image(userImage)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
            } else {
                Color.gray
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
            }
        }
    }

    struct UserFormsSectionView: View {
        let id: String
        let updateIdClosure: (String) -> Void
        let validateIdErrorMessage: String?

        let name: String
        let updateNameClosure: (String) -> Void
        let validateNameErrorMessage: String?

        let introduction: String
        let updateIntroductionClosure: (String) -> Void

        let birthDay: String?
        let updateBirthDayClosure: (String) -> Void
        let birthDayOptions: [String]
        let isPresentBirthDayPickerView: Bool
        let setIsPresentBirthDayPickerViewClosure: (Bool) -> Void

        var body: some View {
            VStack(alignment: .leading) {
                Divider()

                Group {
                    if let errorMessage = validateIdErrorMessage {
                        ErrorMessageView(text: errorMessage)
                            .padding(.horizontal, 16)
                    }
                    IdFormItemView(id: id, updateClosure: updateIdClosure)
                        .padding(.horizontal, 16)
                }

                Divider()

                Group {
                    if let errorMessage = validateNameErrorMessage {
                        ErrorMessageView(text: errorMessage)
                            .padding(.horizontal, 16)
                    }
                    NameFormItemView(name: name, updateClosure: updateNameClosure)
                        .padding(.horizontal, 16)
                }

                Divider()

                IntroductionFormItemView(introduction: introduction, updateClosure: updateIntroductionClosure)
                    .padding(.horizontal, 16)

                Divider()

                BirthDayFormItemView(
                    birthDayOptions: birthDayOptions,
                    birthDay: birthDay,
                    updateClosure: updateBirthDayClosure,
                    isPresentBirthDayPickerView: isPresentBirthDayPickerView,
                    setIsPresentBirthDayPickerViewClosure: setIsPresentBirthDayPickerViewClosure
                )
                    .padding(.horizontal, 16)

                Divider()
            }
        }

        struct IdFormItemView: View {
            let id: String
            let updateClosure: (String) -> Void
            var body: some View {
                HStack {
                    FormLabelView(text: "ID")
                    TextField("5文字以上で設定してください", text: Binding(get: { id }, set: { updateClosure($0) }))
                }
            }
        }

        struct NameFormItemView: View {
            let name: String
            let updateClosure: (String) -> Void

            var body: some View {
                HStack {
                    FormLabelView(text: "名前")
                    TextField("2文字以上で設定してください", text: Binding(get: { name }, set: { updateClosure($0) }))
                }
            }
        }

        struct IntroductionFormItemView: View {
            let introduction: String
            let updateClosure: (String) -> Void

            var body: some View {
                HStack {
                    FormLabelView(text: "自己紹介")
                    TextField("自分の特徴やら何らかの情報を入力してね", text: Binding(get: { introduction }, set: { updateClosure($0) }), axis: .vertical)
                        .lineLimit(5)
                }
            }
        }

        struct BirthDayFormItemView: View {
            let birthDayOptions: [String]
            let birthDay: String?
            let updateClosure: (String) -> Void
            let isPresentBirthDayPickerView: Bool
            let setIsPresentBirthDayPickerViewClosure: (Bool) -> Void

            var body: some View {
                HStack {
                    FormLabelView(text: "誕生日")
                    Text(birthDay ?? "")
                        .onTapGesture {
                            setIsPresentBirthDayPickerViewClosure(true)
                        }
                }
            }
        }

        struct FormLabelView: View {
            let text: String
            var body: some View {
                HStack {
                    Text(text)
                        .bold()
                    Spacer()
                }
                .frame(width: 80)
            }
        }

        struct ErrorMessageView: View {
            let text: String

            var body: some View {
                Text(text)
                    .fontWeight(.light)
                    .font(Font.system(size: 14))
                    .foregroundColor(.red)
            }
        }
    }
    
    struct BirthDayPickerView: View {
        let birthDayOptions: [String]
        let birthDay: String?
        let updateClosure: (String) -> Void
        let setIsPresentClosure: (Bool) -> Void

        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        setIsPresentClosure(false)
                    } label: {
                        Image(systemName: "xmark")
                    }.padding(.trailing, 16)
                }
                Picker(
                    "誕生日",
                    selection: Binding(get: { birthDay ?? "" }, set: { updateClosure($0) })
                ) {
                    ForEach(birthDayOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
}
