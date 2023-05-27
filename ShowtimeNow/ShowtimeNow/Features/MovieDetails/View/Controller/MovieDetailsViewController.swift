//
//  MovieDetailsViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private let viewFactory: MovieDetailsViewProducing
    private let viewModel: MovieDetailsViewModel

    private lazy var detailsView = viewFactory.make()
    
    init(
        viewFactory: MovieDetailsViewProducing,
        viewModel: MovieDetailsViewModel
    ) {
        self.viewFactory = viewFactory
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        setupNavigationItem()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configure() {
        detailsView.title.text = viewModel.title
        detailsView.releaseDate.text = viewModel.releaseDate
        detailsView.rating.text = viewModel.rating
        detailsView.overview.text = viewModel.overview
        
        detailsView.favouriteButton.addTarget(self, action: #selector(likedMovie), for: .touchUpInside)
    }
    
    @objc func likedMovie() {
        // TODO: save status and update view
    }
}
