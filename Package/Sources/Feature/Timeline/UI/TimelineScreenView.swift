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
            if viewStore.state.isLoadingFetchTweets, viewStore.state.tweetItemModels.isEmpty {
                ProgressView()
                    .onAppear {
                        store.send(.onAppear)
                    }
            } else {
                ScrollView {
                    TweetList(
                        tweetItemViewDatas: viewStore.state.tweetItemModels,
                        didTapRetweetClosure: { tweetItemModel in
                            store.send(.didTapRetweet(tweetItemModel))
                        },
                        didTapLikeClosure: { tweetItemModel in
                            store.send(.didTapLike(tweetItemModel))
                        },
                        didTapShareClosure: { tweetItemModel in
                            store.send(.didTapShare(tweetItemModel))
                        },
                        loadUserImageClosure: { tweetItemModel in
                            store.send(.loadImage(tweetItemModel))
                        }
                    )
                }
                .refreshable {
                    store.send(.refresh)
                }
                .overlay(alignment: .bottomTrailing) {
                    TweetButtonView(
                        isPresentedTweetView: viewStore.state.isPresentedTweetView,
                        didTapClosure: { store.send(.setIsPresentedTweetView(true)) }
                    )
                        .padding([.bottom, .trailing], 16)
                }
                .sheet(isPresented: .init(get: {
                    viewStore.state.isPresentedTweetView
                }, set: { bool in
                    store.send(.setIsPresentedTweetView(bool))
                })) {
                    Text("ツイート内容入力")
                }
            }
        }
    }

    struct TweetButtonView: View {
        let isPresentedTweetView: Bool
        let didTapClosure: () -> Void
        var body: some View {
            Button {
                didTapClosure()
            } label: {
                ZStack(alignment: .center) {
                    Color.cyan
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .tint(.white)
                }
            }
        }
    }
}

struct TweetList: View {
    let tweetItemViewDatas: [TweetItemViewData]
    let didTapRetweetClosure: (TweetItemViewData) -> Void
    let didTapLikeClosure: (TweetItemViewData) -> Void
    let didTapShareClosure: (TweetItemViewData) -> Void
    let loadUserImageClosure: (TweetItemViewData) -> Void

    var body: some View {
        VStack {
            ForEach(tweetItemViewDatas, id: \.tweetId) { viewData in
                TweetItemView(
                    viewData: viewData,
                    didTapRetweetClosure: didTapRetweetClosure,
                    didTapLikeClosure: didTapLikeClosure,
                    didTapShareClosure: didTapShareClosure,
                    loadUserImageClosure: loadUserImageClosure
                )
                    .padding(.horizontal, 16)
            }
        }
    }
}

struct TweetItemView: View {
    let viewData: TweetItemViewData
    let didTapRetweetClosure: (TweetItemViewData) -> Void
    let didTapLikeClosure: (TweetItemViewData) -> Void
    let didTapShareClosure: (TweetItemViewData) -> Void
    let loadUserImageClosure: (TweetItemViewData) -> Void

    var body: some View {
        HStack(alignment: .top) {
            UserIconView(
                imageName: viewData.userImageName,
                isLoading: viewData.isLoadingUserImage
            )
            .onAppear {
                loadUserImageClosure(viewData)
            }
            VStack(alignment: .leading) {
                UserSectionView(
                    userName: viewData.userName,
                    userId: viewData.userId,
                    postedAt: viewData.tweetPostedAt
                )
                Spacer().frame(height: 5)
                Text(viewData.tweetText)
                    .fontWeight(.light)
                    .font(Font.system(size: 16))
                Spacer().frame(height: 10)
                ReactionSectionView(
                    isRetweet: viewData.isRetweet,
                    isLike: viewData.isLike,
                    didTapRetweetClosure: { didTapRetweetClosure(viewData) },
                    didTapLikeClosure: { didTapLikeClosure(viewData) },
                    didTapShareClosure: { didTapShareClosure(viewData) }
                )
            }
        }
        Spacer().frame(height: 15)
        Divider()
    }
    
    struct UserIconView: View {
        let imageName: String
        let isLoading: Bool

        var body: some View {
            if isLoading {
                Color.gray
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            } else {
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            }
        }
    }
    
    struct UserSectionView: View {
        let userName: String
        let userId: String
        let postedAt: String

        var body: some View {
            HStack {
                Text(userName)
                    .bold()
                Text("@" + userId)
                    .fontWeight(.light)
                Text("・" + postedAt)
                    .fontWeight(.light)
                    .font(Font.system(size: 14))
            }
        }
    }

    struct ReactionSectionView: View {
        let isRetweet: Bool
        let isLike: Bool
        let didTapRetweetClosure: () -> Void
        let didTapLikeClosure: () -> Void
        let didTapShareClosure: () -> Void

        var body: some View {
            HStack {
                Button {} label: {
                    Image(systemName: "message")
                        .tint(.primary)
                }
                Spacer()
                Button {
                    didTapRetweetClosure()
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .tint( isRetweet ? .green : .primary)
                }
                Spacer()
                Button {
                    didTapLikeClosure()
                } label: {
                    Image(systemName: "heart")
                        .tint(isLike ? .pink : .primary)
                }
                Spacer()
                Button {
                    didTapShareClosure()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .tint(.primary)
                }
                Spacer()
            }
        }
    }
}
