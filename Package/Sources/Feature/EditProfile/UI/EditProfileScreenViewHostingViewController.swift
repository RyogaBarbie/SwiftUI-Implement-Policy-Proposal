import UIKit
import Actomaton
import ActomatonUI

class EditProfileScreenViewHostingViewController: HostingViewController<EditProfileScreenViewModel.Action, EditProfileScreenViewModel.State, EditProfileScreenViewModel._Environment, EditProfileScreenView> {
    private let store: EditProfileScreenViewModel.Store
    
    init(
        store: EditProfileScreenViewModel.Store,
        makeView: @escaping @MainActor (EditProfileScreenViewModel.Store) -> EditProfileScreenView
    ) {
        self.store = store
        super.init(store: store) { store in
            makeView(store)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィールの変更"
    }
}
