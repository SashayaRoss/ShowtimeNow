//
//  MainViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MainViewController: UIViewController {
    private let viewController: MoviesNavigationController
    
    init(viewController: MoviesNavigationController) {
        self.viewController = viewController

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentMovies()
    }

    private func presentMovies() {
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])

        viewController.didMove(toParent: self)
    }
}
