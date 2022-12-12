import SwiftUI
import Actomaton
import ActomatonUI

struct EditProfileScreenView: View {
    private let vm: EditProfileScreenViewModel
    
    init(vm: EditProfileScreenViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        Text("プロフィール変更")
    }
}
