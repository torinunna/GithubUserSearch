//
//  SearchUserResponse.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/02.
//

import Foundation

struct SearchUserResponse: Decodable {
    var items: [SearchResult]
}
