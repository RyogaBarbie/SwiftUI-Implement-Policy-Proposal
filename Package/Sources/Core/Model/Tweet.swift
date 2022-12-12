import Foundation

/// APIのResponseを元に生成される
public struct Tweet: Sendable, Equatable {
    public let id: UUID = UUID()
    public let text: String
    public let postedAt: String
    
    public let replyCount: Int
    public let retweetCount: Int
    public let likeCount: Int

    public var isLike: Bool = false
    public var isRetweet: Bool = false

    public let user: User
    
    public init(text: String, postedAt: String, replyCount: Int, retweetCount: Int, likeCount: Int, user: User) {
        self.text = text
        self.postedAt = postedAt
        self.replyCount = replyCount
        self.retweetCount = retweetCount
        self.likeCount = likeCount
        self.user = user
    }
}

extension Tweet {
    public static func sample() -> [Tweet] {
        [
            .ariyoshi(), .ariyoshi(),
            .matsumoto(), .matsumoto(),
            .nobu(), .nobu(),
            .eiko(), .eiko(),
            .tomoya(), .tomoya(),
            .tori(), .tori(),
            .ryoma(), .ryoma(),
            .ariyoshi(), .ariyoshi(),
            .matsumoto(), .matsumoto(),
            .nobu(), .nobu(),
            .eiko(), .eiko(),
            .tomoya(), .tomoya(),
            .tori(), .tori(),
            .ryoma(), .ryoma()
        ].shuffled().shuffled().shuffled()
    }
}

extension Tweet {
    public static func ariyoshi() -> Tweet {
        Tweet(text: "本日ラジオ。\n街はすっかりクリスマス。", postedAt: "3時間", replyCount: 43, retweetCount: 157, likeCount: 3612, user: .ariyoshi())
    }
    public static func matsumoto() -> Tweet {
        Tweet(text: "今日はオカンの誕生日㊗️\nキティちゃんも誕生日🎉\nどっちも可愛いなぁ〜😌", postedAt: "11月1日", replyCount: 1398, retweetCount: 5397, likeCount: 137000, user: .matsumoto())
    }
    public static func nobu() -> Tweet {
        Tweet(text: "衝撃。。。\n力全抜け。\nメッシ対ロナウドの決勝が見れるかもなー。", postedAt: "12月10日", replyCount: 225, retweetCount: 775, likeCount: 39000, user: .nobu())
    }
    public static func eiko() -> Tweet {
        Tweet(text: "12月3日16時30分\nフジテレビ\n「芸人対抗合唱バトル」まもなくオンエアです！\n合唱、めっちゃ練習しました！\n見てね！！", postedAt: "12月3日", replyCount: 73, retweetCount: 86, likeCount: 1595, user: .eiko())
    }
    public static func tomoya() -> Tweet {
        Tweet(text: "近所のカフェの美味しいドレッシング、原材料何が使われてるんだろうといつも考えながら食べてたんだけど、テイクアウトでそのドレッシングを買ったらボトルのラベルに全部書いてあった。自分で作ってみたいけど、分量がわからん（´-`）", postedAt: "4月26日", replyCount: 966, retweetCount: 2343, likeCount: 36000, user: .tomoya())
    }
    public static func tori() -> Tweet {
        Tweet(text: "代打です。\n菅田、大丈夫だ。安心して休んでくれ。\n何を話そうか。\nリンクスか。\nMD(マスターデュエル)か。DMか。\nリスナーの皆さんよろしくお願いします。#菅田将暉ANN #松坂桃李ANN", postedAt: "3月24日", replyCount: 611, retweetCount: 16000, likeCount: 77000, user: .tori())
    }
    public static func ryoma() -> Tweet {
        Tweet(text: "TOKIOのみなさんハリセンボンのお2人ありがとうございました。\n楽しい収録でした。\n\n約束どおりツイートさせていただきます。\n#TOKIOカケル", postedAt: "1月27日", replyCount: 215, retweetCount: 1509, likeCount: 14000, user: .ryoma())
    }
}
