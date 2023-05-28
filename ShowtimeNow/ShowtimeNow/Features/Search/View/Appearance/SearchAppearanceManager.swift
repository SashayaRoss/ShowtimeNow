//
//  SearchAppearanceManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

final class SearchAppearanceManager {}

extension SearchAppearanceManager: SearchAppearanceManaging {
    func decorate(view: SearchViewInterface) {
        
        view.backgroundColor = .clear
        
        view.errorMessage.font = .systemFont(ofSize: 18, weight: .regular)
        view.errorMessage.textAlignment = .center
        view.errorMessage.numberOfLines = 0
    }
}
