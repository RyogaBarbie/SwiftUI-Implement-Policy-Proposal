import SwiftUI
import Actomaton
import ActomatonUI

struct TimelineScreenView: View {
    private let store: TimelineScreenViewModel.Store
    
    init(store: TimelineScreenViewModel.Store) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            Text("Timline")
            TweetList(tweetItemModels: viewStore.state.tweetItemModels)
        }
    }
}
struct TweetList: View {
    let tweetItemModels: [TweetItemModel]

    var body: some View {
        ForEach(tweetItemModels, id: \.tweet.id) { tweetItemModel in
            TweetItem(tweetItemModel: tweetItemModel)
        }
    }
}

struct TweetItem: View {
    let tweetItemModel: TweetItemModel

    var body: some View {
        Text("ツイート")
    }
}
