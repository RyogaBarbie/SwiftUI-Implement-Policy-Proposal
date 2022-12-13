import Foundation

public enum FollowState: Sendable {
    case follow, unfollow
}

/// APIのResponseを元に生成される
public struct User: Sendable, Equatable {
    public let id: String
    public let name: String
    public let introduction: String
    public let birthDay: String?
    public let imageName: String
    public var isFollow: FollowState?
    
    public init(id: String, name: String, introduction: String, birthDay: String?, imageName: String, isFollow: FollowState? = nil) {
        self.id = id
        self.name = name
        self.introduction = introduction
        self.birthDay = birthDay
        self.imageName = imageName
        self.isFollow = isFollow
    }
}

extension User {
    public static func random() -> User {
        [.ariyoshi(), .matsumoto(), .nobu(), .eiko(), .tomoya(), .tori(), .ryoma()].shuffled().first!
    }

    public static func ariyoshi() -> User {
        User(id: "ariyoshihiroyuki", name: "有吉弘行", introduction: "穏やかに。。。", birthDay: "5月31日", imageName: "ariyoshi")
    }
    public static func matsumoto() -> User {
        User(id: "matsu_bouzu", name: "松本人志", introduction: "所属事務所：吉本興業 コンビ名：ダウンタウン 血液型：Ｂ型", birthDay: "9月8日", imageName: "matsumoto")
    }
    public static func nobu() -> User {
        User(id: "NOBUCHIDORI", name: "千鳥ノブ", introduction: "千鳥ノブです。大漫才師です。サインの横にたまに「夢ひとつ」と添えます。", birthDay: "12月30日", imageName: "nobu")
    }
    public static func eiko() -> User {
        User(id: "kano9x", name: "狩野英孝", introduction: "千鳥ノブです。大漫才師です。サインの横にたまに「夢ひとつ」と添えます。", birthDay: "2月22日", imageName: "eiko")
    }
    public static func tomoya() -> User {
        User(id: "senritsutareme", name: "中村倫也", introduction: "トップコートランド　https://sp.tcland.jp", birthDay: nil, imageName: "tomoya")
    }
    public static func tori() -> User {
        User(id: "MToriofficial", name: "松坂桃李", introduction: "松坂桃李オフィシャルTwitter", birthDay: nil, imageName: "tori")
    }
    public static func ryoma() -> User {
        User(id: "takeuchi_ryoma", name: "竹内涼真", introduction: "竹内涼真オフィシャルアカウント ホリプロ所属 【竹内涼真携帯サイト】http://goo.gl/Kfd42k", birthDay: "4月26日", imageName: "ryoma")
    }
}
