//
//  SearchLayoutManager.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import UIKit

final class SearchLayoutManager {
    private func setupHierarchy(in view: SearchViewInterface) {
        view.addSubview(view.tableView)
        view.addSubview(view.errorMessage)
    }
    
    private func setupConstraints(in view: SearchViewInterface) {
        view.tableView.translatesAutoresizingMaskIntoConstraints = false
        view.errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.errorMessage.topAnchor.constraint(equalTo: view.topAnchor),
            view.errorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.errorMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.errorMessage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SearchLayoutManager: SearchLayoutManaging {
    func layout(view: SearchViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
