//
//  ImageLoading.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import UIKit

protocol ImageLoading {
    func getImage(with imagePath: String, size: Int, completion: @escaping (Result<UIImage, Error>) -> Void)
}
