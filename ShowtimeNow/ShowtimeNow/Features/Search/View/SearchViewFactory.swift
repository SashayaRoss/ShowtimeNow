//
//  SearchViewFactory.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

final class SearchViewFactory {
    private let appearanceManager: SearchAppearanceManaging
    private let layoutManager: SearchLayoutManaging
    
    init(
        appearanceManager: SearchAppearanceManaging,
        layoutManager: SearchLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension SearchViewFactory: SearchViewProducing {
    func make() -> SearchViewInterface {
        let view = SearchView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
