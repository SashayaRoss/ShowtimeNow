//
//  SearchResultsViewController.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResults(_ movie: MovieEntity)
}

final class SearchResultsViewController: UIViewController {
    private let viewFactory: SearchViewProducing
    private let cellViewModelFactory: (_ movie: MovieEntity) -> SearchResultsTableViewCellViewModel
    private var results: [MovieEntity] = []
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private lazy var searchView = viewFactory.make()
    
    init(
        viewFactory: SearchViewProducing,
        cellViewModelFactory: @escaping (_ movie: MovieEntity) -> SearchResultsTableViewCellViewModel
    ) {
        self.viewFactory = viewFactory
        self.cellViewModelFactory = cellViewModelFactory
        
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchView
    }

    private func configure() {
        if let view = view as? SearchViewInterface {
            view.tableView.delegate = self
            view.tableView.dataSource = self
            
            view.tableView.isHidden = true
            view.tableView.register(
                SearchResultsTableViewCell.self,
                forCellReuseIdentifier: NSStringFromClass(SearchResultsTableViewCell.self))
        }
    }
    
    func update(with results: [MovieEntity]) {
        if let view = view as? SearchViewInterface {
            self.results = results
            view.tableView.reloadData()
            view.tableView.isHidden = results.isEmpty
            view.errorMessage.isHidden = true
        }
    }
    
    func handleError(with error: String) {
        if let view = view as? SearchViewInterface {
            view.errorMessage.text = "Error occured: \n\(error)\nTry again later!"
            view.tableView.reloadData()
            view.tableView.isHidden = true
        }
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(SearchResultsTableViewCell.self),
            for: indexPath) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
        let cellViewModel = cellViewModelFactory(results[indexPath.row])
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        delegate?.didTapResults(result)
    }
}
