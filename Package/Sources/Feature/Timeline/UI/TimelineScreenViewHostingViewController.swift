import UIKit
import SwiftUI
import Actomaton
import ActomatonUI

class TimelineScreenViewHostingViewController: HostingViewController<TimelineScreenViewModel.Action, TimelineScreenViewModel.State, TimelineScreenViewModel._Environment, TimelineScreenView> {
    private let store: TimelineScreenViewModel.Store
    
    init(
        store: TimelineScreenViewModel.Store,
        makeView: @escaping @MainActor (TimelineScreenViewModel.Store) -> TimelineScreenView
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
        
        navigationItem.title = "最新ツイート"
    }
}
