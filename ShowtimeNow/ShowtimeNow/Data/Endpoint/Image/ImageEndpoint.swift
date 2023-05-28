//
//  ImageEndpoint.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

struct ImageEndpoint: APIEndpoint {
    var path: String {
        return ""
    }
}

extension ImageEndpoint: ImageProviding {
    func getImagePath(from url: String) -> String {
        return url.replacingOccurrences(of: path, with: "")
    }
}
