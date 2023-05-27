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
    weak var delegate: SearchResultsViewControllerDelegate?
    private var results: [MovieEntity] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(
            SearchResultsTableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(SearchResultsTableViewCell.self))
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [MovieEntity]) {
        DispatchQueue.main.async { [weak self] in
            self?.results = results
            self?.tableView.reloadData()
            self?.tableView.isHidden = results.isEmpty
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
        let result = results[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(SearchResultsTableViewCell.self),
            for: indexPath) as? SearchResultsTableViewCell else {
                return UITableViewCell()
            }
        cell.configure(with: SearchResultsTableViewCellViewModel(
            title: result.title,
            imageURL: URL(string: result.poster_path ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        delegate?.didTapResults(result)
    }
}
