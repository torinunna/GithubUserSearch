//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/01.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    let network = NetworkService(configuration: .default)
    
    @Published private(set) var users: [SearchResult] = []
    var subscriptisons = Set<AnyCancellable>()

    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = SearchResult
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchController()
        configureCollectionView()
        bind()
    }
    
    private func embedSearchController() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "torinunna"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCell.identifier, for: indexPath) as? ResultCell else { return nil }
            cell.user.text = item.login
            return cell
        })
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func bind() {
        $users
            .receive(on: RunLoop.main)
            .sink { users in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.datasource.apply(snapshot)
            }.store(in: &subscriptisons)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search pressed: \(searchBar.text)")
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
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
            .store(in: &subscriptisons)
    }
}
