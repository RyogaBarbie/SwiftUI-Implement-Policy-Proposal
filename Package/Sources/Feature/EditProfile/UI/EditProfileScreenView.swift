import SwiftUI
import Actomaton
import ActomatonUI

struct EditProfileScreenView: View {
    private let vm: EditProfileScreenViewModel
    
    init(vm: EditProfileScreenViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            UserImageSectionView(hasUserCoverImage: false, userImageUrl: vm.state., userCoverImageUrl: <#T##URL#>)
        }
    }

    struct UserImageSectionView: View {
        let hasUserCoverImage: Bool
        let userImageUrl: URL
        let userCoverImageUrl: URL

        var body: some View {
            UserCoverImageView(hasUserCoverImage: hasUserCoverImage)

        }

        struct UserCoverImageView: View {
            let hasUserCoverImage: Bool

            var body: some View {
                if hasUserCoverImage {
                    Image("userCoverImage")
                        .resizable()
                        .frame(height: 120)
                } else {
                    Color.gray
                        .frame(height: 120)
                        .overlay(alignment: .center) {
                            Image(systemName: "camera")
                        }
                }
            }
        }
    }
}
