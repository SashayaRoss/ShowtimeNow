//
//  MovieDetailsView.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieDetailsView: UIView, MovieDetailsViewInterface {
    let scrollView = UIScrollView()
    let containerView = UIStackView()
    let imageView = UIImageView()
    let title = UILabel()
    let releaseDate = UILabel()
    let rating = UILabel()
    let starIcon = UIImageView()
    let overview = UILabel()
}
