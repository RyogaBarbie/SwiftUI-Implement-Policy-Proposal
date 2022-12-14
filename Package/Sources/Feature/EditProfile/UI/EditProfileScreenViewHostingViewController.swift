import UIKit
import SwiftUI

class EditProfileScreenViewHostingViewController: UIHostingController<EditProfileScreenView> {

    private let viewModel: EditProfileScreenViewModel
    private var rightButton: UIBarButtonItem?

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

        setup()
    }
    
    private func setup() {
        navigationItem.title = "プロフィールの変更"
        
        rightButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(didTapSaveButotn))
        navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    func setIsEnableSaveButton(_ bool: Bool) {
        rightButton?.isEnabled = bool
    }
    
    @objc func didTapSaveButotn() {
        viewModel.send(.didTapSave)
    }
}
