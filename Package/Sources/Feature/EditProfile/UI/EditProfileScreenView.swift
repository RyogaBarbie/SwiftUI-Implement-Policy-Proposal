import SwiftUI
import Actomaton
import ActomatonUI

struct EditProfileScreenView: View {
    private let store: EditProfileScreenViewModel.Store
    
    init(store: EditProfileScreenViewModel.Store) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("プロフィール変更")
        }
    }
}
