//
//  MovieListViewInterface.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

protocol MovieListViewInterface: UIView {
    var collectionView: UICollectionView { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
