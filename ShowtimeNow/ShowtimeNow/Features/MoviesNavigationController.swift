//
//  MoviesNavigationController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation
import UIKit

final class MoviesNavigationController: UINavigationController {
    private let listViewController: MovieListViewController

    init(listViewController: MovieListViewController) {
        self.listViewController = listViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presentList()
    }

    private func presentList() {
        pushViewController(listViewController, animated: false)
    }
}

