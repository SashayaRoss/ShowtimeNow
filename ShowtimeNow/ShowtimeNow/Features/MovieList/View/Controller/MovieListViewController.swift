//
//  MovieListViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModel
    private let viewFactory: MovieListViewProducing
    private let cellViewModelFactory: (_ movie: Movie) -> MovieListCellViewModel
    
    private let refresher: UIRefreshControl
    
    private lazy var listView = viewFactory.make()
    
    init(
        viewModel: MovieListViewModel,
        viewFactory: MovieListViewProducing,
        cellViewModelFactory: @escaping (_ movie: Movie) -> MovieListCellViewModel
    ) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        self.cellViewModelFactory = cellViewModelFactory
        self.refresher = UIRefreshControl()
        
        super.init(nibName: nil, bundle: nil)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.loadMovies()
    }
    
    private func setup() {
        setupCollectionView()
        navigationItem.title = "LIST"
        
        self.refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        listView.collectionView.refreshControl = refresher
    }

    private func setupCollectionView() {
        listView.collectionView.delegate = self
        listView.collectionView.dataSource = self
        
        listView.collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieListCollectionViewCell.self))
    }
    
    private func bindToViewModel() {
        viewModel.viewState.bind { [weak self] movieListState in
            guard let strongSelf = self else { return }

            switch movieListState {
            case .loading:
                strongSelf.listView.activityIndicator.startAnimating()
            case .finishedLoading:
                strongSelf.listView.activityIndicator.stopAnimating()
                strongSelf.reloadCollectionView()
            case let .error(error: error):
                strongSelf.listView.activityIndicator.stopAnimating()
                strongSelf.presentError(error: error)
            }
        }
    }
    
    private func reloadCollectionView() {
        listView.isUserInteractionEnabled = false
        DispatchQueue.main.async { [weak self] in
            guard
                let strongSelf = self
            else {
                return
            }
            strongSelf.listView.collectionView.reloadData()
            strongSelf.listView.isUserInteractionEnabled = true
        }
    }
    
    @objc func refresh() {
        self.listView.collectionView.refreshControl?.beginRefreshing()
        viewModel.loadMovies()
        self.listView.collectionView.refreshControl?.endRefreshing()
    }
    
    //TODO: separating ErrorView
    private func presentError(error: Error) {
        let ac = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let submitAction = UIAlertAction(title: "Ok :(", style: .default)
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}


extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MovieListCollectionViewCell.self), for: indexPath) as? MovieListCollectionViewCell else {
            fatalError("Cannot dequeue reusable cell.")
        }

        let cellViewModel = cellViewModelFactory(viewModel.movie(for: indexPath))
        cell.configure(with: cellViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetails(movie: viewModel.movie(for: indexPath))
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = listView.collectionView.safeAreaLayoutGuide.layoutFrame.width
        return CGSize(
            width: width,
            height: 100
        )
    }
}
