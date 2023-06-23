//
//  UserProfile.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/23.
//

import Foundation

struct UserProfile: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var name: String
    var avatarUrl: URL
    var htmlUrl: String
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

extension UserProfile {
    static let mock = UserProfile(
        id: 86116904,
        login: "torinunna",
        name: "torinunna",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/86116904?v=4")!,
        htmlUrl: "https://github.com/torinunna",
        followers: 0,
        following: 3
    )
}
