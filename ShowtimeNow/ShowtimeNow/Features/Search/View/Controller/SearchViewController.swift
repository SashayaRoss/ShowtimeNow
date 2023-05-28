//
//  SearchViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class SearchViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    private let repository: SearchLoading
    private let moviesResponder: MoviesResponder
    private let searchResultsController: UISearchController
    
    init(
        repository: SearchLoading,
        moviesResponder: MoviesResponder,
        searchResultsController: UISearchController
    ) {
        self.repository = repository
        self.moviesResponder = moviesResponder
        self.searchResultsController = searchResultsController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchResultsController()
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupSearchResultsController() {
        searchResultsController.searchResultsUpdater = self
        searchResultsController.searchBar.delegate = self
        searchResultsController.searchBar.placeholder = "Search movie"
        searchResultsController.searchBar.searchBarStyle = .minimal
        searchResultsController.definesPresentationContext = true
        
        navigationItem.searchController = searchResultsController
    }
    
    private func setupNavigation() {
        title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchResultsController.searchResultsController as? SearchResultsViewController,
              let querry = searchBar.text,
              !querry.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultsController.delegate = self

        repository.search(with: querry) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultsController.update(with: results.results)
                case .failure(let error):
                    resultsController.handleError(with: error.localizedDescription)
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResults(_ result: MovieEntity) {
        moviesResponder.showDetail(movie: result)
    }
}
