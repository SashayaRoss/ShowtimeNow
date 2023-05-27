//
//  MoviesNavigationController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation
import UIKit

final class MoviesNavigationController: UINavigationController {
    private let viewModel: MainViewModel
    private let listViewController: MovieListViewController
    private let detailsViewController: (_ movie: MovieEntity) -> MovieDetailsViewController
    private let searchViewController: SearchViewController

    init(
        viewModel: MainViewModel,
        listViewController: MovieListViewController,
        detailsViewController: @escaping (_ movie: MovieEntity) -> MovieDetailsViewController,
        searchViewController: SearchViewController
    ) {
        self.viewModel = viewModel
        self.listViewController = listViewController
        self.detailsViewController = detailsViewController
        self.searchViewController = searchViewController
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        bindToViewModel()
    }
    
    private func setupNavigationBar() {
        navigationBar.tintColor = .label
        navigationBar.prefersLargeTitles = true
    }

    private func bindToViewModel() {
        viewModel.viewState.bind { [weak self] state in
            guard
                let strongSelf = self
            else {
                return
            }

            switch state {
            case .list:
                strongSelf.presentList()
            case let .detail(movie):
                strongSelf.presentDetails(with: movie)
            case .search:
                strongSelf.presentSearch()
            }
        }
    }
    
    private func presentList() {
        pushViewController(listViewController, animated: false)
    }

    private func presentDetails(with movie: MovieEntity) {
        let viewController = detailsViewController(movie)
        pushViewController(viewController, animated: true)
    }
    
    private func presentSearch() {
        let viewController = searchViewController
        pushViewController(viewController, animated: true)
    }
}
