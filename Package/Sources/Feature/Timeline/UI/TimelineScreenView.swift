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
            ScrollView {
                TweetList(tweetItemModels: viewStore.state.tweetItemModels)
            }
            .overlay(alignment: .bottomTrailing) {
                TweetButtonView()
                    .padding([.bottom, .trailing], 16)
            }
        }
    }

    struct TweetButtonView: View {
        var body: some View {
            Button {} label: {
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
    let tweetItemModels: [TweetItemModel]

    var body: some View {
        VStack {
            ForEach(tweetItemModels, id: \.tweet.id) { tweetItemModel in
                TweetItemView(tweetItemModel: tweetItemModel)
                    .padding(.horizontal, 16)
            }
        }
    }
}

struct TweetItemView: View {
    let tweetItemModel: TweetItemModel

    var body: some View {
        HStack(alignment: .top) {
            UserIconView(imageName: tweetItemModel.user.imageName)
            VStack(alignment: .leading) {
                UserSectionView(
                    userName: tweetItemModel.user.name,
                    userId: tweetItemModel.user.id,
                    postedAt: tweetItemModel.tweet.postedAt
                )
                Spacer().frame(height: 5)
                Text(tweetItemModel.tweet.text)
                    .fontWeight(.light)
                    .font(Font.system(size: 16))
                Spacer().frame(height: 10)
                ReactionSectionView()
            }
        }
        Spacer().frame(height: 15)
        Divider()
    }
    
    struct UserIconView: View {
        let imageName: String
        var body: some View {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(25)

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
        var body: some View {
            HStack {
                Button {} label: {
                    Image(systemName: "message")
                        .tint(.primary)
                }
                Spacer()
                Button {} label: {
                    Image(systemName: "arrow.2.squarepath")
                        .tint(.primary)
                }
                Spacer()
                Button {} label: {
                    Image(systemName: "heart")
                        .tint(.primary)
                }
                Spacer()
                Button {} label: {
                    Image(systemName: "square.and.arrow.up")
                        .tint(.primary)
                }
                Spacer()
            }
        }
    }
}
