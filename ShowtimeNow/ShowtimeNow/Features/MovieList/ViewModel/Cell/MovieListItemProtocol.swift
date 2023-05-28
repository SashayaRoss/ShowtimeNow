//
//  MovieListItemProtocol.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

protocol MovieListItemProtocol {
    var title: String { get }
    func getImage(completion: @escaping (UIImage?) -> Void)
}
