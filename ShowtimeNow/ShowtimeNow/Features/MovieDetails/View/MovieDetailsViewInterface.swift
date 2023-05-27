//
//  MovieDetailsViewInterface.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

protocol MovieDetailsViewInterface: UIView {
    var imageView: UIImageView { get }
    var title: UILabel { get }
    var releaseDate: UILabel { get }
    var overview: UILabel { get }
    var rating: UILabel { get }
}
