//
//  ImageEntity.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation
import UIKit

final class ImageEntity: Equatable {
    static func == (lhs: ImageEntity, rhs: ImageEntity) -> Bool {
        return lhs.image == rhs.image && lhs.size == rhs.size
    }
    
    let image: UIImage
    let size: Int
    
    init(image: UIImage, size: Int) {
        self.image = image
        self.size = size
    }
}
