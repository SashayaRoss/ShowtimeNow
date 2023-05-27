//
//  MovieListView.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

final class MovieListView: UIView, MovieListViewInterface {
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5)
                
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(250)),
                    subitem: item,
                    count: 2)

                horizontalGroup.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5)
                
                let section = NSCollectionLayoutSection(group: horizontalGroup)
                return section
        })
    )
    
    let activityIndicator = UIActivityIndicatorView()
}
