//
//  AppDependencyContainer.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class AppDependencyContainer {
    func makeMainViewController() -> MainViewController {
        return MainViewController()
    }
}

