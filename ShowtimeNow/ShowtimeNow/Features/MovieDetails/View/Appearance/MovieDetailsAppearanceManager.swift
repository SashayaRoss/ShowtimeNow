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
        view.imageView.backgroundColor = .customtGray()
        view.imageView.layer.masksToBounds = true
        view.imageView.layer.cornerRadius = 8
        view.imageView.contentMode = .scaleAspectFill
        
        view.title.numberOfLines = 0
        view.title.font = .systemFont(ofSize: 22, weight: .semibold)
        
        view.starIcon.image = UIImage(systemName: "star")
        view.starIcon.tintColor = .turquoise()
        view.starIcon.contentMode = .scaleAspectFill
        
        view.releaseDate.font = .systemFont(ofSize: 16, weight: .light)
        view.rating.font = .systemFont(ofSize: 16, weight: .light)
        
        view.overview.numberOfLines = 0
    }
}
