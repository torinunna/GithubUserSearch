//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/05.
//

import Foundation
import Combine

final class SearchViewModel {
    
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    //    Data
    @Published private(set) var users: [SearchResult] = []
    
    //    User Action
    func search(keyword: String) {
        let resource = Resource<SearchUserResponse>(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
    }
}
