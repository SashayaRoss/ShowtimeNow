//
//  MovieListViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let moviesRepository: MoviesLoading
    
    init(
        moviesRepository: MoviesLoading
    ) {
        self.moviesRepository = moviesRepository
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .red
        
        //TMP:
        self.moviesRepository.getMovies { [weak self] movieResult in
            switch movieResult {
            case let .success(movies):
                print(movies)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
