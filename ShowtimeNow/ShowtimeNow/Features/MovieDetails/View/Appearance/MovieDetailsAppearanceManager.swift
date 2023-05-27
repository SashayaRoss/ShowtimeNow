//
//  MovieDetailsAppearanceManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsAppearanceManager {}

extension MovieDetailsAppearanceManager: MovieDetailsAppearanceManaging {
    func decorate(view: MovieDetailsViewInterface) {
        view.backgroundColor = .white
        
        view.imageView.image = UIImage(systemName: "photo")
        view.imageView.tintColor = .darkBlue()
        view.imageView.layer.masksToBounds = true
        view.imageView.layer.cornerRadius = 8
        view.imageView.contentMode = .scaleAspectFill
        
        view.title.numberOfLines = 0
        
        view.overview.numberOfLines = 0
    }
}
