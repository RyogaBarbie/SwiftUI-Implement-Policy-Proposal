import UIKit
import SwiftUI

class EditProfileScreenViewHostingViewController: UIHostingController<EditProfileScreenView> {

    private let viewModel: EditProfileScreenViewModel
    private let rightButton = UIBarButtonItem(title: "保存", style: .done, target: EditProfileScreenViewHostingViewController.self, action: nil)

    init(
        _ view: EditProfileScreenView,
        viewModel: EditProfileScreenViewModel
    ) {
        self.viewModel = viewModel
        super.init(rootView: view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "プロフィールの変更"
        navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    func setIsEnableSaveButton(_ bool: Bool) {
        rightButton.isEnabled = bool
    }
}


//import UIKit
//import Actomaton
//import ActomatonUI
//
//class EditProfileScreenViewHostingViewController: HostingViewController<EditProfileScreenViewModel.Action, EditProfileScreenViewModel.State, EditProfileScreenViewModel._Environment, EditProfileScreenView> {
//    private let store: EditProfileScreenViewModel.Store
//
//    init(
//        store: EditProfileScreenViewModel.Store,
//        makeView: @escaping @MainActor (EditProfileScreenViewModel.Store) -> EditProfileScreenView
//    ) {
//        self.store = store
//        super.init(store: store) { store in
//            makeView(store)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationItem.title = "プロフィールの変更"
//    }
//}
