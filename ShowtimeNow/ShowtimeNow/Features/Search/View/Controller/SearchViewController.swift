//
//  SearchViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    private let repository: SearchLoading
    
    private let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Search movie"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    init(repository: SearchLoading) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = .white
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupNavigation() {
        title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let querry = searchBar.text,
              !querry.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        repository.search(with: querry) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultsController.update(with: results.results)
                case .failure(let error):
                    //MOCK:
                    let results: [MovieEntity] = [
                        MovieEntity(
                            id: 1,
                            title: "Mocked Title 1",
                            backdrop_path: nil,
                            poster_path: nil,
                            overview: "Some mock overview",
                            release_date: nil,
                            vote_average: 5.5
                        ),
                        MovieEntity(
                            id: 2,
                            title: "Mocked Title 2"
                            , backdrop_path: nil,
                            poster_path: nil,
                            overview: "Some overView 213 12321 ",
                            release_date: nil,
                            vote_average: 5.5),
                    ]
                    resultsController.update(with: results)
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResults(_ result: MovieEntity) {
        print("test: \(result)")
//        let vc = MovieDetailsViewController(album: model)
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
    }
}
